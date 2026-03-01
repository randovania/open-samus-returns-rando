from pathlib import Path

import ips

here = Path(__file__).parent
connector = here / "msr-remote-connector"
exefs_patches = here / ".." / "src" / "open_samus_returns_rando" / "files" / "exefs_patches"

with (connector / "bak" / "exheader.bin").open("rb") as old, \
        (connector / "exheader.bin").open("rb") as new, \
        (exefs_patches / "exheader.ips").open("wb") as result:
    result.write(bytes(ips.Patch.create(old, new)))

with (connector / "bak" / "code.bin").open("rb") as old, \
        (connector / "code.bin").open("rb") as new, \
        (exefs_patches / "code.ips").open("wb") as result:
    result.write(bytes(ips.Patch.create(old, new)))
