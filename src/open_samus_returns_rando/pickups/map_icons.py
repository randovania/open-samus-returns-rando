MODEL_ICON_MAPPING = {
    # DNA
    "adn": "item_adn",

    # tanks
    "item_energytank": "item_energytank",
    "item_missiletank": "item_missiletank",
    "item_supermissiletank": "item_supermissiletank",
    "item_powerbombtank": "item_powerbombtank",
    "item_senergytank": "item_senergytank",

    # reserve tanks
    "powerup_missilereservetank": "item_missiletank",
    "powerup_energyreservetank": "item_energytank",
    "powerup_aeionreservetank": "item_senergytank",

    # offworld
    "offworld_generic": "item_offworld",

    # nothing
    "itemsphere": "item_nothing",
}


def get_map_icon_data(name: str) -> str:
    return MODEL_ICON_MAPPING.get(name, MODEL_ICON_MAPPING["itemsphere"])
