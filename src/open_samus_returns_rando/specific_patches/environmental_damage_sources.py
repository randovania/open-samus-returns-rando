import itertools

from mercury_engine_data_structures.formats.bmsld import ActorLayer

_AREA_1_HEAT_ACTORS = [
    ("s010_area1", ActorLayer.ENV_TRIGGER, "TG_Heat_001")
]

_AREA_1_LAVA_ACTORS = [
    ("s010_area1", ActorLayer.TRIGGER, "Lava_Trigger_001")
]

_AREA_2_HEAT_ACTORS = [
    ("s020_area2", ActorLayer.ENV_TRIGGER, "TG_SP_Heat_001"),
    ("s020_area2", ActorLayer.TRIGGER, "TG_Heat_002"),
    ("s025_area2b", ActorLayer.ENV_TRIGGER, "TG_SP_Heat_001")
]

_AREA_2_LAVA_ACTORS = [
    ("s020_area2", ActorLayer.TRIGGER, "TG_Lava_001"),
    ("s020_area2", ActorLayer.TRIGGER, "TG_Lava_002"),
    ("s020_area2", ActorLayer.TRIGGER, "TG_Lava_003"),
    ("s020_area2", ActorLayer.TRIGGER, "TG_Lava_004")
]

_AREA_3_HEAT_ACTORS = [
    ("s033_area3b", ActorLayer.ENV_TRIGGER, "TG_Heat_Rando_001"),
    ("s036_area3c", ActorLayer.ENV_TRIGGER, "TG_Heat_Rando_001")
]

_AREA_3_LAVA_ACTORS = [
    ("s033_area3b", ActorLayer.TRIGGER, "TG_Lava_001"),
    ("s033_area3b", ActorLayer.TRIGGER, "TG_Lava_002"),
    ("s036_area3c", ActorLayer.TRIGGER, "TG_Lava_001"),
    ("s036_area3c", ActorLayer.TRIGGER, "TG_Lava_002")
]

_AREA_4_HEAT_ACTORS = [
    ("s040_area4", ActorLayer.ENV_TRIGGER, "TG_Heat_Rando_001"),
    ("s050_area5", ActorLayer.ENV_TRIGGER, "TG_Heat_Rando_001"),
    ("s050_area5", ActorLayer.ENV_TRIGGER, "TG_Heat_Rando_002")
]

_AREA_4_LAVA_ACTORS = [
    ("s040_area4", ActorLayer.TRIGGER, "TG_Lava_001"),
    ("s040_area4", ActorLayer.TRIGGER, "TG_Lava_002"),
    ("s040_area4", ActorLayer.TRIGGER, "TG_Lava_003"),
    ("s050_area5", ActorLayer.TRIGGER, "TG_Lava_001"),
    ("s050_area5", ActorLayer.TRIGGER, "TG_Lava_003"),
    ("s050_area5", ActorLayer.TRIGGER, "TG_Lava_005")
]

_AREA_5_HEAT_ACTORS = [
    ("s065_area6b", ActorLayer.ENV_TRIGGER, "TG_Heat_Rando_001"),
    ("s067_area6c", ActorLayer.ENV_TRIGGER, "TG_Heat_Rando_001")
]

_AREA_5_LAVA_ACTORS = [
    ("s065_area6b", ActorLayer.TRIGGER, "TG_Lava_001"),
    ("s067_area6c", ActorLayer.TRIGGER, "TG_Lava_001"),
    ("s067_area6c", ActorLayer.TRIGGER, "TG_Lava_002"),
    ("s067_area6c", ActorLayer.TRIGGER, "TG_Lava_003"),
    ("s067_area6c", ActorLayer.TRIGGER, "TG_Lava_004")
]

ALL_DAMAGE_ROOM_ACTORS = list(itertools.chain(
    _AREA_1_HEAT_ACTORS,
    _AREA_1_LAVA_ACTORS,
    _AREA_2_HEAT_ACTORS,
    _AREA_2_LAVA_ACTORS,
    _AREA_3_HEAT_ACTORS,
    _AREA_3_LAVA_ACTORS,
    _AREA_4_HEAT_ACTORS,
    _AREA_4_LAVA_ACTORS,
    _AREA_5_HEAT_ACTORS,
    _AREA_5_LAVA_ACTORS,
))
