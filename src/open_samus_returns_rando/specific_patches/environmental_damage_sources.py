import itertools

_AREA_1_HEAT_ACTORS = [
    {
        "scenario": "s010_area1",
        "layer": 2,
        "actor": "TG_Heat_001"
    }
]

_AREA_1_LAVA_ACTORS = [
    {
        "scenario": "s010_area1",
        "layer": 0,
        "actor": "Lava_Trigger_001"
    }
]

_AREA_2_HEAT_ACTORS = [
    {
        "scenario": "s020_area2",
        "layer": 2,
        "actor": "TG_SP_Heat_001"
    },
    {
        "scenario": "s020_area2",
        "layer": 0,
        "actor": "TG_Heat_002"
    },
    {
        "scenario": "s025_area2b",
        "layer": 2,
        "actor": "TG_SP_Heat_001"
    }
]

_AREA_2_LAVA_ACTORS = [
    {
        "scenario": "s020_area2",
        "layer": 0,
        "actor": "TG_Lava_001"
    },
    {
        "scenario": "s020_area2",
        "layer": 0,
        "actor": "TG_Lava_002"
    },
    {
        "scenario": "s020_area2",
        "layer": 0,
        "actor": "TG_Lava_003"
    },
    {
        "scenario": "s020_area2",
        "layer": 0,
        "actor": "TG_Lava_004"
    }
]

_AREA_3_HEAT_ACTORS = [
    {
        "scenario": "s033_area3b",
        "layer": 2,
        "actor": "TG_Heat_Rando_001"
    },
    {
        "scenario": "s036_area3c",
        "layer": 2,
        "actor": "TG_Heat_Rando_001"
    }
]

_AREA_3_LAVA_ACTORS = [
    {
        "scenario": "s033_area3b",
        "layer": 0,
        "actor": "TG_Lava_001"
    },
    {
        "scenario": "s033_area3b",
        "layer": 0,
        "actor": "TG_Lava_002"
    },
    {
        "scenario": "s036_area3c",
        "layer": 0,
        "actor": "TG_Lava_001"
    },
    {
        "scenario": "s036_area3c",
        "layer": 0,
        "actor": "TG_Lava_002"
    }
]

_AREA_4_HEAT_ACTORS = [
    {
        "scenario": "s040_area4",
        "layer": 2,
        "actor": "TG_Heat_Rando_001"
    },
    {
        "scenario": "s050_area5",
        "layer": 2,
        "actor": "TG_Heat_Rando_001"
    },
    {
        "scenario": "s050_area5",
        "layer": 2,
        "actor": "TG_Heat_Rando_002"
    }
]

_AREA_4_LAVA_ACTORS = [
    {
        "scenario": "s040_area4",
        "layer": 0,
        "actor": "TG_Lava_001"
    },
    {
        "scenario": "s040_area4",
        "layer": 0,
        "actor": "TG_Lava_002"
    },
    {
        "scenario": "s040_area4",
        "layer": 0,
        "actor": "TG_Lava_003"
    },
    {
        "scenario": "s050_area5",
        "layer": 0,
        "actor": "TG_Lava_001"
    },
    {
        "scenario": "s050_area5",
        "layer": 0,
        "actor": "TG_Lava_003"
    },
    {
        "scenario": "s050_area5",
        "layer": 0,
        "actor": "TG_Lava_005"
    }
]

_AREA_5_HEAT_ACTORS = [
    {
        "scenario": "s065_area6b",
        "layer": 2,
        "actor": "TG_Heat_Rando_001"
    },
    {
        "scenario": "s067_area6c",
        "layer": 2,
        "actor": "TG_Heat_Rando_001"
    }
]

_AREA_5_LAVA_ACTORS = [
    {
        "scenario": "s065_area6b",
        "layer": 0,
        "actor": "TG_Lava_001"
    },
    {
        "scenario": "s067_area6c",
        "layer": 0,
        "actor": "TG_Lava_001"
    },
    {
        "scenario": "s067_area6c",
        "layer": 0,
        "actor": "TG_Lava_002"
    },
    {
        "scenario": "s067_area6c",
        "layer": 0,
        "actor": "TG_Lava_003"
    },
    {
        "scenario": "s067_area6c",
        "layer": 0,
        "actor": "TG_Lava_004"
    }
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
