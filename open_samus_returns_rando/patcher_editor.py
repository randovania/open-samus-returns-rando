import typing
from pathlib import Path

from mercury_engine_data_structures.file_tree_editor import FileTreeEditor
from mercury_engine_data_structures.formats import BaseResource, Bmsld
from mercury_engine_data_structures.game_check import Game

T = typing.TypeVar("T")


def path_for_level(level_name: str) -> str:
    return f"maps/levels/c10_samus/{level_name}/{level_name}"


class PatcherEditor(FileTreeEditor):
    memory_files: dict[str, BaseResource]

    def __init__(self, root: Path):
        super().__init__(root, Game.SAMUS_RETURNS)
        self.memory_files = {}

    def get_file(self, path: str, type_hint: type[T] = BaseResource) -> T:
        if path not in self.memory_files:
            self.memory_files[path] = self.get_parsed_asset(path, type_hint=type_hint)
        return self.memory_files[path]

    def get_level_pkgs(self, name: str) -> set[str]:
        return set(self.find_pkgs(path_for_level(name) + ".bmsld"))

    def ensure_present_in_scenario(self, scenario: str, asset):
        for pkg in self.get_level_pkgs(scenario):
            self.ensure_present(pkg, asset)

    def get_scenario(self, name: str) -> Bmsld:
        return self.get_file(path_for_level(name) + ".bmsld", Bmsld)

    def flush_modified_assets(self):
        for name, resource in self.memory_files.items():
            self.replace_asset(name, resource)
        self.memory_files = {}
