import typing

from mercury_engine_data_structures.base_resource import BaseResource
from mercury_engine_data_structures.file_tree_editor import FileTreeEditor
from mercury_engine_data_structures.formats import Bmsld
from mercury_engine_data_structures.game_check import Game

from open_samus_returns_rando.constants import ALL_SCENARIOS, get_package_name
from open_samus_returns_rando.romfs.packaged_romfs import PackagedRomFs
from open_samus_returns_rando.romfs.rom3ds import Rom3DS

T = typing.TypeVar("T")


def path_for_level(level_name: str) -> str:
    return f"maps/levels/c10_samus/{level_name}/{level_name}"


class PatcherEditor(FileTreeEditor):
    memory_files: dict[str, BaseResource]

    def __init__(self, parsed_rom: Rom3DS):
        super().__init__(PackagedRomFs(parsed_rom), Game.SAMUS_RETURNS)
        self.memory_files = {}

    def get_file(self, path: str, type_hint: type[T] = BaseResource) -> T: # type: ignore
        if path not in self.memory_files:
            self.memory_files[path] = self.get_parsed_asset(path, type_hint=type_hint) # type: ignore
        return self.memory_files[path] # type: ignore

    def get_level_pkgs(self, name: str) -> set[str]:
        return set(self.find_pkgs(path_for_level(name) + ".bmsld"))

    def get_all_level_pkgs(self) -> list[str]:
        def get_nested_list() -> typing.Iterable[set[str]]:
            for scenario in ALL_SCENARIOS:
                yield self.get_level_pkgs(scenario)
        return [pkg for all_level_pkgs in get_nested_list() for pkg in all_level_pkgs]

    def ensure_present_in_scenario(self, scenario: str, asset: str) -> None:
        for pkg in self.get_level_pkgs(scenario):
            self.ensure_present(get_package_name(pkg, asset), asset)

    def get_scenario(self, name: str) -> Bmsld:
        return self.get_file(path_for_level(name) + ".bmsld", Bmsld)

    def flush_modified_assets(self) -> None:
        for name, resource in self.memory_files.items():
            self.replace_asset(name, resource)
        self.memory_files = {}

    def get_asset_names_in_folder(self, folder: str) -> typing.Iterator[str]:
        yield from (
            name
            for name in self._name_for_asset_id.values()
            if name.startswith(folder) and self.does_asset_exists(name)
        )

