import copy
import typing
from pathlib import Path

from construct import Container  # type: ignore[import-untyped]
from mercury_engine_data_structures.file_tree_editor import FileTreeEditor
from mercury_engine_data_structures.formats import BaseResource, Bmsld
from mercury_engine_data_structures.game_check import Game

from open_samus_returns_rando.constants import ALL_SCENARIOS, get_package_name

T = typing.TypeVar("T")


def path_for_level(level_name: str) -> str:
    return f"maps/levels/c10_samus/{level_name}/{level_name}"


class PatcherEditor(FileTreeEditor):
    memory_files: dict[str, BaseResource]

    def __init__(self, root: Path):
        super().__init__(root, Game.SAMUS_RETURNS)
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

    def resolve_actor_reference(self, ref: dict) -> Container:
        scenario = self.get_scenario(ref["scenario"])
        # FIXME: There is no "default" as layer in SR
        layer = int(ref.get("layer", "default"))
        return scenario.raw.actors[layer][ref["actor"]]

    def flush_modified_assets(self) -> None:
        for name, resource in self.memory_files.items():
            self.replace_asset(name, resource)
        self.memory_files = {}

    def copy_actor(self, scenario: str, coords: list[float], template_actor: Container, new_name: str,
                   layer_index: int, offset: tuple = (0, 0, 0)) -> Container:
        new_actor = copy.deepcopy(template_actor)
        current_scenario = self.get_scenario(scenario)
        current_scenario.raw.actors[layer_index][new_name] = new_actor
        new_actor["position"][0] = coords[0] + offset[0]
        new_actor["position"][1] = coords[1] + offset[1]
        new_actor["position"][2] = coords[2] + offset[2]

        return new_actor

    def remove_entity(self, reference: dict)-> None:
        scenario = self.get_scenario(reference["scenario"])
        layer = reference["layer"]
        actor_name = reference["actor"]

        scenario.raw.actors[layer].pop(actor_name)
        scenario.remove_actor_from_all_groups(actor_name)

    def get_asset_names_in_folder(self, folder: str) -> typing.Iterator[str]:
        yield from (
            name
            for name in self._name_for_asset_id.values()
            if name.startswith(folder) and self.does_asset_exists(name)
        )

