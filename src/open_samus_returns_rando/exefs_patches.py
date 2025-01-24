from pathlib import Path

from open_samus_returns_rando.files import files_path


def create_exefs_patches(
        out_code: Path, out_exheader: Path, input_code: bytes | None, input_exheader: bytes
    ) -> None:
    if input_code is None:
        raise ValueError("Could not get decompressed + decrypted code binary")

    import ips  # type: ignore

    # code.bin patching
    code_ips_path = files_path().joinpath("exefs_patches", "code.ips")
    out_code.parent.mkdir(parents=True, exist_ok=True)
    with (
          Path.open(code_ips_path, "rb") as code_ips,
          Path.open(out_code, "wb") as result
        ):
        content = code_ips.read()
        patch = ips.Patch.load(content)
        patch.apply(input_code, result)
    
    # exheader.bin patching
    # Citra and Luma don't support patching the exheader. User needs to provide it as input and
    # here the patch is just applied
    exheader_ips_path = files_path().joinpath("exefs_patches", "exheader.ips")
    out_exheader.parent.mkdir(parents=True, exist_ok=True)
    with (
          Path.open(exheader_ips_path, "rb") as exheader_ips,
          Path.open(out_exheader, "wb") as result
        ):
        content = exheader_ips.read()
        patch = ips.Patch.load(content)
        patch.apply(input_exheader, result)
