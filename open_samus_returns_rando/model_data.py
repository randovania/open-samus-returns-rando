import dataclasses
from typing import Optional, Tuple


@dataclasses.dataclass(frozen=True)
class Transform:
    position: Tuple[float, float, float] = (0.0, 0.0, 0.0)
    angle: Tuple[float, float, float] = (0.0, 0.0, 0.0)
    scale: Tuple[float, float, float] = (1.0, 1.0, 1.0)


@dataclasses.dataclass(frozen=True)
class ModelData:
    bcmdl_path: str
    dependencies: tuple[str, ...]
    transform: Optional[Transform] = None


ALL_MODEL_DATA: dict[str, ModelData] = {
    "itemsphere": ModelData(
        bcmdl_path="actors/items/itemsphere/models/itemsphere.bcmdl",
        dependencies=(
            "actors/items/itemsphere/models/itemsphere.bcmdl",
            "actors/items/itemsphere/animations/droparachnus.bcskla",
            "actors/items/itemsphere/animations/relax.bcskla",
            "actors/items/itemsphere/fx/itemsphereexplode.bcptl",
            "actors/items/itemsphere/fx/itemsphereparts.bcptl",
        ),
    ),

    "adn": ModelData(
        bcmdl_path="actors/items/adn/models/adn.bcmdl",
        dependencies=(
            "actors/items/adn/charclasses/adn.bmsad",
            "actors/items/adn/fx/adnleak.bcptl",
            "actors/items/adn/models/adn.bcmdl",
            "actors/items/adn/models/textures/adn_d.bctex",
            "actors/items/adn/scripts/adn.lc",
        ),
    ),

    "powerup_wavebeam": ModelData(
        bcmdl_path="actors/items/powerup_wavebeam/models/powerup_wavebeam.bcmdl",
        dependencies=(
            "actors/items/powerup_wavebeam/charclasses/powerup_wavebeam.bmsad",
            "actors/items/powerup_wavebeam/models/powerup_wavebeam.bcmdl",
            "actors/items/itemsphere/models/itemsphere.bcmdl",
            "actors/items/powerup_wavebeam/models/textures/itemspherecoat.bctex",
            "actors/items/powerup_wavebeam/models/textures/itemspherewavebeam_d.bctex",
            "actors/items/powerup_wavebeam/scripts/powerup_wavebeam.lc",
        ),
    ),
    
    "powerup_spazerbeam": ModelData(
        bcmdl_path="actors/items/powerup_spazerbeam/models/powerup_spazerbeam.bcmdl",
        dependencies=(
            "actors/items/powerup_spazerbeam/charclasses/powerup_spazerbeam.bmsad",
            "actors/items/powerup_spazerbeam/models/powerup_spazerbeam.bcmdl",
            "actors/items/powerup_spazerbeam/models/textures/itemspazerbeam_d.bctex",
            "actors/items/powerup_spazerbeam/scripts/powerup_spazerbeam.lc",
        ),
    ),

    "powerup_plasmabeam": ModelData(
        bcmdl_path="actors/items/powerup_plasmabeam/models/powerup_plasmabeam.bcmdl",
        dependencies=(
            "actors/items/powerup_plasmabeam/charclasses/powerup_plasmabeam.bmsad",
            "actors/items/powerup_plasmabeam/models/powerup_plasmabeam.bcmdl",
            "actors/items/powerup_plasmabeam/models/textures/itemplasmabeam_d.bctex",
            "actors/items/powerup_plasmabeam/scripts/powerup_plasmabeam.lc",
        ),
    ),

    "powerup_chargebeam": ModelData(
        bcmdl_path="actors/items/powerup_chargebeam/models/powerup_chargebeam.bcmdl",
        dependencies=(
            "actors/items/powerup_chargebeam/charclasses/powerup_chargebeam.bmsad",
            "actors/items/powerup_chargebeam/models/powerup_chargebeam.bcmdl",
            "actors/items/powerup_chargebeam/models/textures/itemspherechargebeam_d.bctex",
            "actors/items/powerup_chargebeam/scripts/powerup_chargebeam.lc",
        ),
    ),

    "powerup_icebeam": ModelData(
        bcmdl_path="actors/items/powerup_icebeam/models/powerup_icebeam.bcmdl",
        dependencies=(
            "actors/items/powerup_icebeam/charclasses/powerup_icebeam.bmsad",
            "actors/items/powerup_icebeam/models/powerup_icebeam.bcmdl",
            "actors/items/powerup_icebeam/models/textures/itemsphereicebeam_d.bctex",
            "actors/items/powerup_icebeam/scripts/powerup_icebeam.lc",
        ),
    ),

    "powerup_grapplebeam": ModelData(
        bcmdl_path="actors/items/powerup_grapplebeam/models/powerup_grapplebeam.bcmdl",
        dependencies=(
            "actors/items/powerup_grapplebeam/charclasses/powerup_grapplebeam.bmsad",
            "actors/items/powerup_grapplebeam/models/powerup_grapplebeam.bcmdl",
            "actors/items/powerup_grapplebeam/models/textures/itemgrapplebeam_d.bctex",
            "actors/items/powerup_grapplebeam/scripts/powerup_grapplebeam.lc",
        ),
    ),

    "powerup_supermissile": ModelData(
        bcmdl_path="actors/items/powerup_supermissile/models/powerup_supermissile.bcmdl",
        dependencies=(
            "actors/items/powerup_supermissile/charclasses/powerup_supermissile.bmsad",
            "actors/items/powerup_supermissile/models/powerup_supermissile.bcmdl",
            "actors/items/powerup_supermissile/scripts/powerup_supermissile.lc",
        ),
    ),

    "powerup_scanningpulse": ModelData(
        bcmdl_path="actors/items/powerup_scanningpulse/models/powerup_scanningpulse.bcmdl",
        dependencies=(
            "actors/items/powerup_scanningpulse/charclasses/powerup_scanningpulse.bmsad",
            "actors/items/powerup_scanningpulse/fx/orb.bcptl",
            "actors/items/powerup_scanningpulse/models/powerup_scanningpulse.bcmdl",
            "actors/items/powerup_scanningpulse/scripts/powerup_scanningpulse.lc",
        ),
        transform=Transform(
            position=(0.0, 30.0, 0.0),
        )
    ),

    "powerup_energyshield": ModelData(
        bcmdl_path="actors/items/powerup_energyshield/models/powerup_energyshield.bcmdl",
        dependencies=(
            "actors/items/powerup_energyshield/charclasses/powerup_energyshield.bmsad",
            "actors/items/powerup_energyshield/fx/orb.bcptl",
            "actors/items/powerup_energyshield/fx/lightingarmourloop.bcptl",
            "actors/items/powerup_energyshield/models/powerup_energyshield.bcmdl",
            "actors/items/powerup_energyshield/scripts/powerup_energyshield.lc",
        ),
        transform=Transform(
            position=(0.0, 30.0, 0.0),
        )
    ),

    "powerup_energywave": ModelData(
        bcmdl_path="actors/items/powerup_energywave/models/powerup_energywave.bcmdl",
        dependencies=(
            "actors/items/powerup_energywave/charclasses/powerup_energywave.bmsad",
            "actors/items/powerup_energywave/fx/yelloworb.bcptl",
            "actors/items/powerup_energywave/fx/energywaveloop.bcptl",
            "actors/items/powerup_energywave/models/powerup_energywave.bcmdl",
            "actors/items/powerup_energywave/scripts/powerup_energywave.lc",
        ),
        transform=Transform(
            position=(0.0, 30.0, 0.0),
        )
    ),

    "powerup_phasedisplacement": ModelData(
        bcmdl_path="actors/items/powerup_phasedisplacement/models/powerup_phasedisplacement.bcmdl",
        dependencies=(
            "actors/items/powerup_phasedisplacement/charclasses/powerup_phasedisplacement.bmsad",
            "actors/items/powerup_phasedisplacement/fx/purpleorb.bcptl",
            "actors/items/powerup_phasedisplacement/fx/phasedisplacementloop.bcptl",
            "actors/items/powerup_phasedisplacement/models/powerup_phasedisplacement.bcmdl",
            "actors/items/powerup_phasedisplacement/scripts/powerup_phasedisplacement.lc",
        ),
        transform=Transform(
            position=(0.0, 30.0, 0.0),
        )
    ),

    "powerup_variasuit": ModelData(
        bcmdl_path="actors/items/powerup_variasuit/models/powerup_variasuit.bcmdl",
        dependencies=(
            "actors/items/powerup_variasuit/charclasses/powerup_variasuit.bmsad",
            "actors/items/powerup_variasuit/models/powerup_variasuit.bcmdl",
            "actors/items/powerup_variasuit/models/textures/itemspherecoat.bctex",
            "actors/items/powerup_variasuit/models/textures/itemvariasuit_d.bctex",
            "actors/items/powerup_variasuit/scripts/powerup_variasuit.lc",
            "actors/items/itemsphere/animations/relax.bcskla",
        ),
    ),

    "powerup_gravitysuit": ModelData(
        bcmdl_path="actors/items/powerup_gravitysuit/models/powerup_gravitysuit.bcmdl",
        dependencies=(
            "actors/items/powerup_gravitysuit/charclasses/powerup_gravitysuit.bmsad",
            "actors/items/powerup_gravitysuit/models/powerup_gravitysuit.bcmdl",
            "actors/items/powerup_gravitysuit/models/textures/cubemetroids.bctex",
            "actors/items/powerup_gravitysuit/models/textures/itemgravitysuit_d.bctex",
            "actors/items/powerup_gravitysuit/scripts/powerup_gravitysuit.lc",
            "actors/items/itemsphere/animations/relax.bcskla",
        ),
    ),

    "powerup_morphball": ModelData(
        bcmdl_path="actors/items/powerup_morphball/models/powerup_morphball.bcmdl",
        dependencies=(
            "actors/items/powerup_morphball/charclasses/powerup_morphball.bmsad",
            "actors/items/powerup_morphball/models/powerup_morphball.bcmdl",
            "actors/items/powerup_morphball/models/textures/powerup_morphball_d.bctex",
            "actors/items/powerup_morphball/scripts/powerup_morphball.lc",
        ),
    ),

    "powerup_bomb": ModelData(
        bcmdl_path="actors/items/powerup_bomb/models/powerup_bomb.bcmdl",
        dependencies=(
            "actors/items/powerup_bomb/charclasses/powerup_bomb.bmsad",
            "actors/items/powerup_bomb/models/powerup_bomb.bcmdl",
            "actors/items/powerup_bomb/models/textures/powerup_bomb.bctex",
            "actors/items/powerup_bomb/scripts/powerup_bomb.lc",
        ),
    ),

    "powerup_springball": ModelData(
        bcmdl_path="actors/items/powerup_springball/models/powerup_springball.bcmdl",
        dependencies=(
            "actors/items/powerup_springball/charclasses/powerup_springball.bmsad",
            "actors/items/powerup_springball/models/powerup_springball.bcmdl",
            "actors/items/itemsphere/models/itemsphere.bcmdl",
            "actors/items/powerup_springball/models/textures/itemspringball_d.bctex",
            "actors/items/powerup_springball/scripts/powerup_springball.lc",
        ),
    ),

    "powerup_spiderball": ModelData(
        bcmdl_path="actors/items/powerup_spiderball/models/powerup_spiderball.bcmdl",
        dependencies=(
            "actors/items/powerup_spiderball/charclasses/powerup_spiderball.bmsad",
            "actors/items/powerup_spiderball/models/powerup_spiderball.bcmdl",
            "actors/items/powerup_spiderball/models/textures/powerup_morphball_d.bctex",
            "actors/items/powerup_spiderball/scripts/powerup_spiderball.lc",
        ),
        transform=Transform(
            position=(0.0, 30.0, 0.0),
        )
    ),

    "powerup_highjumpboots": ModelData(
        bcmdl_path="actors/items/powerup_highjumpboots/models/highjumpboots.bcmdl",
        dependencies=(
            "actors/items/powerup_highjumpboots/charclasses/powerup_highjumpboots.bmsad",
            "actors/items/powerup_highjumpboots/models/powerup_highjumpboots.bcmdl",
            "actors/items/powerup_highjumpboots/models/textures/itemspherehighjumpboots_d.bctex",
            "actors/items/powerup_highjumpboots/scripts/powerup_highjumpboots.lc",
        ),
    ),

    "powerup_spacejump": ModelData(
        bcmdl_path="actors/items/powerup_spacejump/models/powerup_spacejump.bcmdl",
        dependencies=(
            "actors/items/powerup_spacejump/charclasses/powerup_spacejump.bmsad",
            "actors/items/powerup_spacejump/models/powerup_spacejump.bcmdl",
            "actors/items/powerup_spacejump/models/textures/itemspacejump_d.bctex",
            "actors/items/powerup_spacejump/scripts/powerup_spacejump.lc",
        ),
    ),

    "powerup_screwattack": ModelData(
        bcmdl_path="actors/items/powerup_screwattack/models/powerup_screwattack.bcmdl",
        dependencies=(
            "actors/items/powerup_screwattack/charclasses/powerup_screwattack.bmsad",
            "actors/items/powerup_screwattack/models/powerup_screwattack.bcmdl",
            "actors/items/powerup_screwattack/models/textures/itemscrewattack_d.bctex",
            "actors/items/powerup_screwattack/scripts/powerup_screwattack.lc",
        ),
    ),

    "item_energytank": ModelData(
        bcmdl_path="actors/items/item_energytank/models/item_energytank.bcmdl",
        dependencies=(
            "actors/items/item_energytank/charclasses/item_energytank.bmsad",
            "actors/items/item_energytank/models/item_energytank.bcmdl",
            "actors/items/item_energytank/models/textures/energytank_d.bctex",
            "actors/items/item_energytank/models/textures/tankglow.bctex",
            "actors/items/item_energytank/models/textures/weaponstank_d.bctex",
            "actors/items/item_energytank/scripts/item_energytank.lc",
        ),
    ),

    "item_senergytank": ModelData(
        bcmdl_path="actors/items/item_senergytank/models/item_senergytank.bcmdl",
        dependencies=(
            "actors/items/item_senergytank/charclasses/item_senergytank.bmsad",
            "actors/items/item_senergytank/models/item_senergytank.bcmdl",
            "actors/items/item_senergytank/models/textures/spenergytank_d.bctex",
            "actors/items/item_senergytank/scripts/item_senergytank.lc",
        ),
    ),

    "item_missiletank": ModelData(
        bcmdl_path="actors/items/item_missiletank/models/item_missiletank.bcmdl",
        dependencies=(
            "actors/items/item_missiletank/charclasses/item_missiletank.bmsad",
            "actors/items/item_missiletank/models/item_missiletank.bcmdl",
            "actors/items/item_missiletank/scripts/item_missiletank.lc",
        ),
    ),

    "item_supermissiletank": ModelData(
        bcmdl_path="actors/items/item_supermissiletank/models/item_supermissiletank.bcmdl",
        dependencies=(
            "actors/items/item_supermissiletank/charclasses/item_supermissiletank.bmsad",
            "actors/items/item_supermissiletank/models/item_supermissiletank.bcmdl",
            "actors/items/item_supermissiletank/scripts/item_supermissiletank.lc",
        ),
    ),

    "item_powerbombtank": ModelData(
        bcmdl_path="actors/items/item_powerbombtank/models/item_powerbombtank.bcmdl",
        dependencies=(
            "actors/items/item_powerbombtank/charclasses/item_powerbombtank.bmsad",
            "actors/items/item_powerbombtank/models/item_powerbombtank.bcmdl",
            "actors/items/item_powerbombtank/scripts/item_powerbombtank.lc",
        ),
    ),

    "powerup_powerbomb": ModelData(
        bcmdl_path="actors/items/powerup_powerbomb/models/powerup_powerbomb.bcmdl",
        dependencies=(
            "actors/items/powerup_powerbomb/charclasses/powerup_powerbomb.bmsad",
            "actors/items/powerup_powerbomb/models/powerup_powerbomb.bcmdl",
            "actors/items/powerup_powerbomb/models/textures/powerbomb_d.bctex",
            "actors/items/powerup_powerbomb/scripts/powerup_powerbomb.lc",
        ),
    ),
}


def get_data(name: str) -> ModelData:
    return ALL_MODEL_DATA.get(name, ALL_MODEL_DATA["itemsphere"])
