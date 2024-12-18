from pathlib import Path

from open_samus_returns_rando.files import files_path
from open_samus_returns_rando.lua_editor import get_parent_for
from open_samus_returns_rando.misc_patches.lua_util import lua_convert


def get_lua_for_item(progression: list[list[dict[str, str | int]]], region_name: str) -> str:
    generic_pickup = """
    Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
    MultiworldPickup = MultiworldPickup or {}
    function MultiworldPickup.main()
    end

    function MultiworldPickup.OnPickedUp(progression, actorOrName, regionName)
        RandomizerPowerup.OnPickedUp(progression, actorOrName, regionName)
    end
    """

    main_item_id = str(progression[0][0]["item_id"])
    parent = get_parent_for(main_item_id)
    if parent == "RandomizerPowerup":
        parent_content = generic_pickup
    else:
        parent_lower = parent.lower()
        parent_content = files_path().joinpath("pickups", f"{parent_lower}.lua").read_text()
        parent_content = parent_content.replace(parent, "MultiworldPickup")

    progression_as_lua = lua_convert(progression, True)
    return (f'{parent_content}\nMultiworldPickup.OnPickedUp({progression_as_lua},nil,{region_name})'
            .replace("\n", "\\\n").replace("'", "\\'")
    )


def create_exefs_patches(
        out_code: Path, out_exheader: Path, input_code: bytes | None, input_exheader: bytes, enabled: bool
    ) -> None:
    if not enabled:
        return

    if input_code is None:
        raise ValueError("Could not get decompressed + decrypted code binary")

    import ips  # type: ignore

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

    code_ips_path = files_path().joinpath("exefs_patches", "code.ips")
    out_code.parent.mkdir(parents=True, exist_ok=True)
    with (
          Path.open(code_ips_path, "rb") as code_ips,
          Path.open(out_code, "wb") as result
        ):
        content = code_ips.read()
        patch = ips.Patch.load(content)
        patch.apply(input_code, result)
