# constant data, including "magic numbers" and common data that many modules use

# list of all scenarios
ALL_SCENARIOS = [
    "s000_surface",
    "s010_area1",
    "s020_area2",
    "s025_area2b",
    "s028_area2c",
    "s030_area3",
    "s033_area3b",
    "s036_area3c",
    "s040_area4",
    "s050_area5",
    "s060_area6",
    "s065_area6b",
    "s067_area6c",
    "s070_area7",
    "s090_area9",
    "s100_area10",
    "s110_surfaceb",
]

def get_package_name(package_name: str, file_name: str) -> str:
    without = ["bcmdl", "bcwav", "bctex", "bcskla", "bcptl"]
    for ending in without:
        if file_name.endswith(ending):
            return package_name.replace("_discardables", "")
    return package_name

def lua_pkgs(pkgs: list[str]) -> list[str]:
    return [get_package_name(level_pkg, "lc") for level_pkg in pkgs]
