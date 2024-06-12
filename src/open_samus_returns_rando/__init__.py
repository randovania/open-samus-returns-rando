from pathlib import Path

from .patch_util import patch_with_status_update


def patch(input_path: Path, input_exheader: Path | None, output_path: Path, configuration: dict) -> None:
    from .samus_returns_patcher import patch_extracted
    return patch_extracted(input_path, input_exheader, output_path, configuration)


__all__ = [
    "patch",
    "patch_with_status_update",
]
