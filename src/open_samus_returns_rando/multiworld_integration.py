from pathlib import Path

from open_samus_returns_rando.files import files_path
from open_samus_returns_rando.lua_editor import get_parent_for
from open_samus_returns_rando.misc_patches.lua_util import lua_convert


def get_lua_for_item(progression: list[list[dict[str, str | int]]]) -> str:
    generic_pickup = """
    Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
    MultiworldPickup = MultiworldPickup or {}
    function MultiworldPickup.main()
    end

    function MultiworldPickup.OnPickedUp(progression, actorOrName)
        RandomizerPowerup.OnPickedUp(progression, actorOrName)
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
    return (f'{parent_content}\nMultiworldPickup.OnPickedUp({progression_as_lua}, nil)'
            .replace("\n", "\\\n").replace("'", "\\'")
    )


def create_exefs_patches(
        out_code: Path, out_exheader: Path, input_exheader: Path | None, enabled: bool, region: str
    ) -> None:
    if not enabled or input_exheader is None:
        return

    import shutil

    import ips  # type: ignore

    # Citra and Luma don't support patching the exheader. User needs to provide it as input and
    # here the patch is just applied
    exheader_ips_path = files_path().joinpath("exefs_patches", "exheader.ips")
    out_exheader.parent.mkdir(parents=True, exist_ok=True)
    with (
          Path.open(exheader_ips_path, "rb") as exheader_ips,
          Path.open(input_exheader, "rb") as original,
          Path.open(out_exheader, "wb") as result
        ):
        content = exheader_ips.read()
        patch = ips.Patch.load(content)
        patch.apply(original, result)

    # copy bps patch (don't ask me why the patch does not work as IPS format)
    shutil.copyfile(files_path().joinpath("exefs_patches", f"code_{region}.bps"), out_code)
