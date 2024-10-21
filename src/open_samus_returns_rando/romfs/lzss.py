# Lzss structure was taken from GodMode9 https://github.com/d0k3/GodMode9/commit/a6a15eb70d66e3c96bbc164598f9482bb545b3f9

from construct import Struct  # type: ignore
from construct.core import Int32ul  # type: ignore

LzssFooter = Struct(
    "off_size_comp" / Int32ul,  # 0xOOSSSSSS, where O == reverse offset and S == size
    "addsize_dec" / Int32ul,  # decompressed size - compressed size
)


def lzss_decompress(compressed: bytes) -> bytes | None:
    # copy of citra's `LZSS_Decompress` function
    # see: https://github.com/PabloMK7/citra/blob/7d00f47c5ead75db0a9f24d70aa4b609e85125d8/src/core/file_sys/ncch_container.cpp#L54
    compressed_length = len(compressed)

    lzss_footer = LzssFooter.parse(compressed[-8:])

    decompressed_length = compressed_length + lzss_footer.addsize_dec
    decompressed = bytearray(decompressed_length)

    out = decompressed_length
    index = compressed_length - ((lzss_footer.off_size_comp >> 24) & 0xFF)
    stop_index = compressed_length - (lzss_footer.off_size_comp & 0xFFFFFF)

    decompressed[0:compressed_length] = compressed
    while index > stop_index:
        index -= 1
        control = compressed[index]

        for i in range(8):
            if index <= stop_index:
                break
            if index <= 0:
                break
            if out <= 0:
                break

            if control & 0x80:
                # Check if compression is out of bounds
                if index < 2:
                    return None
                index -= 2

                segment_offset = compressed[index] | (compressed[index + 1] << 8)
                segment_size = ((segment_offset >> 12) & 15) + 3
                segment_offset &= 0x0FFF
                segment_offset += 2

                # Check if compression is out of bounds
                if out < segment_size:
                    return None

                for j in range(segment_size):
                    # Check if compression is out of bounds
                    if out + segment_offset >= decompressed_length:
                        return None

                    data = decompressed[out + segment_offset]
                    out -= 1
                    decompressed[out] = data
            else:
                # Check if compression is out of bounds
                if out < 1:
                    return None
                out -= 1
                index -= 1
                decompressed[out] = compressed[index]

            control <<= 1
    return decompressed
