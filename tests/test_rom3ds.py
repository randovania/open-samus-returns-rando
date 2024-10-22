from pathlib import Path

import pytest

from open_samus_returns_rando.romfs.rom3ds import Rom3DS, parse_rom_file


@pytest.mark.parametrize("rom_ending", [".cxi", ".cia", ".3ds"])
def test_compare_pkg_sr(samus_returns_roms_path, rom_ending):
    file_path = samus_returns_roms_path.joinpath("MSR" + rom_ending)
    with Path.open(file_path, "rb") as file_stream:
        rom = Rom3DS(parse_rom_file(file_path, file_stream), file_stream)
        # deactivated to not let other users tests fail when they use a NTSC version
        # assert rom.get_title_id() == "00040000001BFB00"
        # assert rom.is_pal()
        assert rom.get_file_binary("gui/scripts/loadingscreen.lc")[:6] == b"\x1bLuaQ\x00"
        code_binary = rom.get_code_binary()
        assert code_binary is not None
        assert code_binary[:6] == b"\x07\x00\x00\xeb\x92#"
        assert rom.exheader()[:8] == b"MATADORA"
