# Parsing the file and structures is copied from various sources whatever was the easiest to read.
# Big part is citra source. (current most active fork is pablomk7's https://github.com/PabloMK7/citra/blob/master/src/core/file_sys/ncch_container.h)
# Reading the Ivfc container for the RomFS and cia from ctrtool https://github.com/3DSGuy/Project_CTR/tree/master/ctrtool/src


from io import BufferedReader
from pathlib import Path

import construct
from construct.core import (
    AlignedStruct,
    Array,
    Bytes,
    Const,
    Int8ul,
    Int16ul,
    Int32ul,
    Int64ul,
    PascalString,
    Seek,
    Struct,
    Tell,
)

from open_samus_returns_rando.romfs.lzss import lzss_decompress

SectionGeometry = Struct(
    "offset" / Int32ul,
    "size" / Int32ul,
)

RomFsHeader = Struct(
    "header_size" / Int32ul,
    "dir_hash_bucket" / SectionGeometry,
    "dir_entry" / SectionGeometry,
    "file_hash_bucket" / SectionGeometry,
    "file_entry" / SectionGeometry,
    "data_offset" / Int32ul,
)

NCSDPartitions = Struct("offset" / Int32ul, "size" / Int32ul)

NCSD = Struct(
    "signature" / Bytes(0x100),
    "magic" / Bytes(4),
    "media_size" / Int32ul,
    "media_id" / Bytes(8),
    "partition_fs_type" / Bytes(8),
    "partition_crypt_type" / Bytes(8),
    "partitions" / Array(8, NCSDPartitions),
    "extended_header_hash" / Bytes(0x20),
    "additional_header_size" / Int32ul,
    "sector_zero_offset" / Int32ul,
    "partition_flags" / Bytes(8),
    "partition_id_table" / Bytes(0x40),
    "reserved" / Bytes(0x30),
)

NCCH = Struct(
    "signature" / Bytes(0x100),
    "magic" / Bytes(4),
    "content_size" / Int32ul,
    "partition_id" / Bytes(8),
    "maker_code" / Int16ul,
    "version" / Int16ul,
    "reserved_0" / Bytes(4),
    "program_id" / Bytes(8),
    "reserved_1" / Bytes(0x10),
    "logo_region_hash" / Bytes(0x20),
    "product_code" / Bytes(0x10),
    "extended_header_hash" / Bytes(0x20),
    "extended_header_size" / Int32ul,
    "reserved_2" / Bytes(4),
    "reserved_flag" / Bytes(3),
    "secondary_key_slot" / Int8ul,
    "platform" / Int8ul,
    "thing" / Int8ul,
    "content_unit_size" / Int8ul,
    "thing2" / Int8ul,
    "plain_region_offset" / Int32ul,
    "plain_region_size" / Int32ul,
    "logo_region_offset" / Int32ul,
    "logo_region_size" / Int32ul,
    "exefs_offset" / Int32ul,
    "exefs_size" / Int32ul,
    "exefs_hash_region_size" / Int32ul,
    "reserved_3" / Bytes(4),
    "romfs_offset" / Int32ul,
    "romfs_size" / Int32ul,
    "romfs_hash_region_size" / Int32ul,
    "reserved_4" / Bytes(4),
    "exefs_super_block_hash" / Bytes(0x20),
    "romfs_super_block_hash" / Bytes(0x20),
)

ROMStructure = Struct(
    "ncch_offset" / Tell,
    "ncch" / NCCH,
    "ncchexheader" / Bytes(0x800),
    "_goto_exe_fs" / Seek(construct.this.ncch_offset + construct.this.ncch.exefs_offset * 0x200),
    "_exe_fs_offset" / Tell,
    # assume first section is the .code section
    "code_section" / Struct("name" / Const(b".code\x00\x00\x00", Bytes(8)), "offset" / Int32ul, "size" / Int32ul),
    # exe_fs_offset + offset mentioned in code seciton + size of the header
    "_goto_code_bin" / Seek(construct.this._exe_fs_offset + construct.this.code_section.offset + 0x200),
    "code_binary" / Bytes(construct.this.code_section.size),
    # jump over ivfc header which is 0x5c + padding, followed by the
    # master hash but then everthing is 0x1000 bytes aligned
    # => just jump directly to ivfc header + 0x1000
    "_goto_romfs_header" / Seek(construct.this.ncch_offset + (construct.this.ncch.romfs_offset * 0x200) + 0x1000),
    "_romfs_header_offset" / Tell,
    "romfs_header" / RomFsHeader,
    # dir entry
    "_goto_dir_entry_table" / Seek(construct.this._romfs_header_offset + construct.this.romfs_header.dir_entry.offset),
    "dir_entry_table" / Bytes(construct.this.romfs_header.dir_entry.size),
    # file entry
    "_goto_file_entry_table"
    / Seek(construct.this._romfs_header_offset + construct.this.romfs_header.file_entry.offset),
    "file_entry_table" / Bytes(construct.this.romfs_header.file_entry.size),
    # start of romfs files, everything beyond this point is parsed by using the filestream directly
    "_goto_romfs_files" / Seek(construct.this._romfs_header_offset + construct.this.romfs_header.data_offset),
)

Add3ds = Struct(
    # in general, we would need to peek the bytes 0x100 - 0x104 first to see if it
    # is a NCSD or NCCH. (0x0 - 0x100 are the signature)
    "ncsd" / NCSD,
    # there is a lot of card data, test data etc. totally irrelevant see https://www.3dbrew.org/wiki/NCSD
    "_garbage" / Seek(construct.this.ncsd.partitions[0].offset * 0x200), # type: ignore (no idea why it wants a string)
    "rom_struct" / ROMStructure,
)

AddCia = Struct(
    "header_size" / Int32ul,
    "type" / Int16ul,
    "format_version" / Int16ul,
    "certificate_size" / Int32ul,
    "ticket_size" / Int32ul,
    "tmd_size" / Int32ul,
    "footer_size" / Int32ul,
    "content_size" / Int32ul,
    # FIXME: there must be an easier way to skip over these aligned sections
    "_return_to_start" / Seek(0),
    "_garbage"
    / AlignedStruct(
        64,
        "header" / Bytes(construct.this._.header_size),
        "certificate" / Bytes(construct.this._.certificate_size),
        "ticket" / Bytes(construct.this._.ticket_size),
        "tmd" / Bytes(construct.this._.tmd_size),
    ),
    "rom_struct" / ROMStructure,
)

AddCxi = Struct(
    "rom_struct" / ROMStructure,
)

RomFsDirectoryEntry = Struct(
    "parent_offset" / Int32ul,
    "sibling_offset" / Int32ul,
    "child_offset" / Int32ul,
    "file_offset" / Int32ul,
    "hash_sibling_offset" / Int32ul,
    "name" / PascalString(Int32ul, "utf_16_le"),
)

RomFsFileEntry = Struct(
    "parent_offset" / Int32ul,
    "sibling_offset" / Int32ul,
    "data_offset" / Int64ul,
    "data_size" / Int64ul,
    "hash_sibling_offset" / Int32ul,
    "name" / PascalString(Int32ul, "utf_16_le"),
)


def parse_rom_file(file_path: Path, file_stream: BufferedReader) -> construct.Container:
    try:
        if file_path.suffix == ".cia":
            raw = AddCia.parse_stream(file_stream)
            return raw
        elif file_path.suffix == ".3ds":
            raw = Add3ds.parse_stream(file_stream)
            return raw
        elif file_path.suffix == ".app" or file_path.suffix == ".cxi":
            raw = AddCxi.parse_stream(file_stream)
            return raw
        else:
            raise ValueError('Input does not end with ".cia", ".3ds", ".app" or ".cxi"')
        # encrypted files should throw a ConstError because the ".code" string is encrypted and parsing fails
    except construct.ConstError:
        raise ValueError("Rom file could not be parsed. Make sure that you use a decrypted supported file format.")


class DirectoryEntry:
    complete_path: str

    def __init__(self, parent_path: str, entry: construct.Container):
        self._entry = entry
        if parent_path == "":
            self.complete_path = self._entry.name
        else:
            self.complete_path = parent_path + "/" + self._entry.name


class FileEntry:
    complete_path: str
    data_size: int
    data_offset: int

    def __init__(self, parent_path: str, entry: construct.Container):
        self._entry = entry
        if parent_path == "":
            self.complete_path = self._entry.name
        else:
            self.complete_path = parent_path + "/" + self._entry.name
        self.data_size = entry.data_size
        self.data_offset = entry.data_offset


class Rom3DS:
    raw: construct.Container
    file_stream: BufferedReader
    file_name_to_entry: dict[str, FileEntry]

    def __init__(self, raw: construct.Container, file_stream: BufferedReader):
        self.file_name_to_entry = {}
        self.file_stream = file_stream
        self.raw = raw
        self.read_rom_fs()

    def get_title_id(self) -> str:
        title_id = self.raw.rom_struct.ncch.program_id[::-1]
        return title_id.hex().upper()

    def is_pal(self) -> bool:
        # there is probably a more general method but region info is embedded in the icon. out of scope for now
        return self.get_title_id() == "00040000001BFB00"

    def _is_code_binary_compressed(self) -> bool:
        # first 8 bytes are the name, followed by 5 reserved bytes, followed by a flag byte where the first bit
        # tells if compressed
        is_compressed = self.raw.rom_struct.ncchexheader[13] & 0x01
        return is_compressed

    def get_file_binary(self, path: str) -> bytes:
        entry = self.file_name_to_entry[path]
        self.file_stream.seek(self.raw.rom_struct._goto_romfs_files + entry.data_offset)
        return self.file_stream.read(entry.data_size)

    def read_rom_fs(self) -> None:
        def get_dir_entry(offset: int) -> construct.Container:
            start = self.raw.rom_struct.dir_entry_table[offset:]
            result = RomFsDirectoryEntry.parse(start)
            return result

        def get_file_entry(offset: int) -> construct.Container:
            start = self.raw.rom_struct.file_entry_table[offset:]
            result = RomFsFileEntry.parse(start)
            return result

        # relative to the start of the section
        offset = 0
        offset_to_dir_entry: dict[int, DirectoryEntry] = {}

        while offset < self.raw.rom_struct.romfs_header.dir_entry.size:
            current_entry = get_dir_entry(offset)
            # the names are stored in utf-16 in the file, so they take 2 bytes
            size = len(current_entry.name) * 2
            parent_path = offset_to_dir_entry[current_entry.parent_offset].complete_path if offset != 0 else ""
            offset_to_dir_entry[offset] = DirectoryEntry(parent_path, current_entry)
            # size of the entry + aligned name
            offset = offset + 0x18 + (-size % 4) + size

        offset = 0

        while offset < self.raw.rom_struct.romfs_header.file_entry.size:
            current_entry = get_file_entry(offset)
            # the names are stored in utf-16 in the file, so they take 2 bytes
            size = len(current_entry.name) * 2
            parent_path = offset_to_dir_entry[current_entry.parent_offset].complete_path
            entry = FileEntry(parent_path, current_entry)
            self.file_name_to_entry[entry.complete_path] = entry
            # size of the entry + aligned name
            offset = offset + 0x20 + (-size % 4) + size

    def get_code_binary(self) -> bytes | None:
        if self._is_code_binary_compressed():
            compressed = self.raw.rom_struct.code_binary
            return lzss_decompress(compressed)
        else:
            return self.raw.rom_struct.code_binary

    def exheader(self) -> bytes:
        return self.raw.rom_struct.ncchexheader
