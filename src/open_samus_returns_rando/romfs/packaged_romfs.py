import io
from collections.abc import Iterator
from contextlib import contextmanager

import construct  # type: ignore
from mercury_engine_data_structures.romfs import RomFs

from open_samus_returns_rando.romfs.rom3ds import Rom3DS


class PackagedRomFs(RomFs):
    def __init__(self, parsed_rom: Rom3DS):
        self.parsed_rom = parsed_rom

    @contextmanager
    def get_pkg_stream(self, file_path: str) -> Iterator[io.BytesIO]:
        file_stream = io.BytesIO(self.parsed_rom.get_file_binary(file_path))
        try:
            yield file_stream
        finally:
            file_stream.close()

    def read_file_with_entry(self, file_path: str, entry: construct.Container) -> bytes:
        with io.BytesIO(self.parsed_rom.get_file_binary(file_path)) as f:
            f.seek(entry.start_offset)
            return f.read(entry.end_offset - entry.start_offset)

    def get_file(self, file_path: str) -> bytes:
        return self.parsed_rom.get_file_binary(file_path)

    def all_files(self) -> Iterator[str]:
        yield from self.parsed_rom.file_name_to_entry.keys()
