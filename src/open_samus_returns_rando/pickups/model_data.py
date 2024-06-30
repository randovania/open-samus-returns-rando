import dataclasses


@dataclasses.dataclass(frozen=True)
class ModelData:
    bcmdl_path: str
    dependencies: tuple[str, ...]


ALL_MODEL_DATA: dict[str, ModelData] = {
    "itemsphere": ModelData(
        bcmdl_path="actors/items/itemsphere/models/itemsphere.bcmdl",
        dependencies=(
            "actors/items/itemsphere/models/itemsphere.bcmdl",
            "actors/items/itemsphere/animations/droparachnus.bcskla",
            "actors/items/itemsphere/animations/relax.bcskla",
            "actors/items/itemsphere/fx/itemsphereexplode.bcptl",
            "actors/items/itemsphere/fx/itemsphereparts.bcptl",
            "maps/textures/chozoartifactor_d.bctex",
            "maps/textures/chozoartifactorbase_d.bctex",
            "system/fx/textures/explosion3.bctex",
            "system/fx/textures/flare.bctex",
            "system/fx/textures/grapplebreak2.bctex",
            "system/fx/textures/halfwave.bctex",
            "system/fx/textures/haloflame.bctex",
            "system/fx/textures/impact2.bctex",
            "system/fx/textures/splat.bctex",
        ),
    ),
    "adn": ModelData(
        bcmdl_path="actors/items/adn/models/adn.bcmdl",
        dependencies=(
            "actors/items/adn/fx/adnleak.bcptl",
            "actors/items/adn/models/adn.bcmdl",
            "actors/items/adn/models/textures/adn_d.bctex",
            "system/fx/textures/flare.bctex",
            "system/fx/textures/leavessegments_l.bctex",
            "system/fx/textures/steam.bctex",
            "system/fx/textures/twistsmoke_l.bctex",
        ),
    ),
    "babyhatchling": ModelData(
        bcmdl_path="actors/characters/babyhatchling/models/babyhatchlingsmall.bcmdl",
        dependencies=(
            "actors/characters/babyhatchling/models/babyhatchlingsmall.bcmdl",
            "actors/characters/babyhatchling/models/babyhatchling.bcmdl",
        ),
    ),
    "powerup_wavebeam": ModelData(
        bcmdl_path="actors/items/powerup_wavebeam/models/powerup_wavebeam.bcmdl",
        dependencies=(
            "actors/items/powerup_wavebeam/models/powerup_wavebeam.bcmdl",
            "actors/items/powerup_wavebeam/models/textures/itemspherecoat.bctex",
            "actors/items/powerup_wavebeam/models/textures/itemspherewavebeam_d.bctex",
        ),
    ),
    "powerup_spazerbeam": ModelData(
        bcmdl_path="actors/items/powerup_spazerbeam/models/powerup_spazerbeam.bcmdl",
        dependencies=(
            "actors/items/powerup_spazerbeam/models/powerup_spazerbeam.bcmdl",
            "actors/items/powerup_spazerbeam/models/textures/itemspazerbeam_d.bctex",
        ),
    ),
    "powerup_plasmabeam": ModelData(
        bcmdl_path="actors/items/powerup_plasmabeam/models/powerup_plasmabeam.bcmdl",
        dependencies=(
            "actors/items/powerup_plasmabeam/models/powerup_plasmabeam.bcmdl",
            "actors/items/powerup_plasmabeam/models/textures/itemplasmabeam_d.bctex",
        ),
    ),
    "powerup_chargebeam": ModelData(
        bcmdl_path="actors/items/powerup_chargebeam/models/powerup_chargebeam.bcmdl",
        dependencies=(
            "actors/items/powerup_chargebeam/models/powerup_chargebeam.bcmdl",
            "actors/items/powerup_chargebeam/models/textures/itemspherechargebeam_d.bctex",
        ),
    ),
    "powerup_icebeam": ModelData(
        bcmdl_path="actors/items/powerup_icebeam/models/powerup_icebeam.bcmdl",
        dependencies=(
            "actors/items/powerup_icebeam/models/powerup_icebeam.bcmdl",
            "actors/items/powerup_icebeam/models/textures/itemsphereicebeam_d.bctex",
        ),
    ),
    "powerup_grapplebeam": ModelData(
        bcmdl_path="actors/items/powerup_grapplebeam/models/powerup_grapplebeam.bcmdl",
        dependencies=(
            "actors/items/powerup_grapplebeam/models/powerup_grapplebeam.bcmdl",
            "actors/items/powerup_grapplebeam/models/textures/itemgrapplebeam_d.bctex",
        ),
    ),
    "powerup_supermissile": ModelData(
        bcmdl_path="actors/items/powerup_supermissile/models/powerup_supermissile.bcmdl",
        dependencies=(
            "actors/items/powerup_supermissile/models/powerup_supermissile.bcmdl",
        ),
    ),
    "powerup_scanningpulse": ModelData(
        bcmdl_path="actors/items/powerup_scanningpulse/models/powerup_scanningpulse.bcmdl",
        dependencies=(
            "actors/items/powerup_scanningpulse/fx/orb.bcptl",
            "actors/items/powerup_scanningpulse/fx/scanpulseloop.bcptl",
            "actors/items/powerup_scanningpulse/models/powerup_scanningpulse.bcmdl",
            "system/fx/textures/energytornado.bctex",
            "system/fx/textures/glow.bctex",
            "system/fx/textures/halfwave.bctex",
            "system/fx/textures/haloflame.bctex",
            "system/fx/textures/impact2.bctex",
            "system/fx/textures/leavessegments_l.bctex",
            "system/fx/textures/shaft2.bctex",
            "system/fx/textures/spinenergy_l.bctex",
            "system/fx/textures/tracer2.bctex",
            "system/fx/textures/xflare_large.bctex",
        ),
    ),
    "powerup_energyshield": ModelData(
        bcmdl_path="actors/items/powerup_energyshield/models/powerup_energyshield.bcmdl",
        dependencies=(
            "actors/items/powerup_energyshield/fx/orb.bcptl",
            "actors/items/powerup_energyshield/fx/lightingarmourloop.bcptl",
            "actors/items/powerup_energyshield/models/powerup_energyshield.bcmdl",
            "actors/items/powerup_scanningpulse/models/powerup_scanningpulse.bcmdl",
            "system/fx/textures/energytornado.bctex",
            "system/fx/textures/glow.bctex",
            "system/fx/textures/halfwave.bctex",
            "system/fx/textures/haloflame.bctex",
            "system/fx/textures/impact2.bctex",
            "system/fx/textures/leavessegments_l.bctex",
            "system/fx/textures/shaft2.bctex",
            "system/fx/textures/spinenergy_l.bctex",
            "system/fx/textures/tracer2.bctex",
            "system/fx/textures/xflare_large.bctex",
        ),
    ),
    "powerup_energywave": ModelData(
        bcmdl_path="actors/items/powerup_energywave/models/powerup_energywave.bcmdl",
        dependencies=(
            "actors/items/powerup_energywave/fx/yelloworb.bcptl",
            "actors/items/powerup_energywave/fx/energywaveloop.bcptl",
            "actors/items/powerup_energywave/models/powerup_energywave.bcmdl",
            "actors/items/powerup_scanningpulse/models/powerup_scanningpulse.bcmdl",
            "system/fx/textures/energytornado.bctex",
            "system/fx/textures/glow.bctex",
            "system/fx/textures/halfwave.bctex",
            "system/fx/textures/haloflame.bctex",
            "system/fx/textures/impact2.bctex",
            "system/fx/textures/leavessegments_l.bctex",
            "system/fx/textures/shaft2.bctex",
            "system/fx/textures/spinenergy_l.bctex",
            "system/fx/textures/tracer2.bctex",
            "system/fx/textures/xflare_large.bctex",
        ),
    ),
    "powerup_phasedisplacement": ModelData(
        bcmdl_path="actors/items/powerup_phasedisplacement/models/powerup_phasedisplacement.bcmdl",
        dependencies=(
            "actors/items/powerup_phasedisplacement/fx/purpleorb.bcptl",
            "actors/items/powerup_phasedisplacement/fx/phasedisplacementloop.bcptl",
            "actors/items/powerup_phasedisplacement/models/powerup_phasedisplacement.bcmdl",
            "actors/items/powerup_scanningpulse/models/powerup_scanningpulse.bcmdl",
            "system/fx/textures/energytornado.bctex",
            "system/fx/textures/glow.bctex",
            "system/fx/textures/halfwave.bctex",
            "system/fx/textures/haloflame.bctex",
            "system/fx/textures/impact2.bctex",
            "system/fx/textures/leavessegments_l.bctex",
            "system/fx/textures/shaft2.bctex",
            "system/fx/textures/spinenergy_l.bctex",
            "system/fx/textures/tracer2.bctex",
            "system/fx/textures/xflare_large.bctex",
        ),
    ),
    "powerup_variasuit": ModelData(
        bcmdl_path="actors/items/powerup_variasuit/models/powerup_variasuit.bcmdl",
        dependencies=(
            "actors/items/powerup_variasuit/models/powerup_variasuit.bcmdl",
            "actors/items/powerup_variasuit/models/textures/itemspherecoat.bctex",
            "actors/items/powerup_variasuit/models/textures/itemvariasuit_d.bctex",
        ),
    ),
    "powerup_gravitysuit": ModelData(
        bcmdl_path="actors/items/powerup_gravitysuit/models/powerup_gravitysuit.bcmdl",
        dependencies=(
            "actors/items/powerup_gravitysuit/models/powerup_gravitysuit.bcmdl",
            "actors/items/powerup_gravitysuit/models/textures/cubemetroids.bctex",
            "actors/items/powerup_gravitysuit/models/textures/itemgravitysuit_d.bctex",
        ),
    ),
    "powerup_morphball": ModelData(
        bcmdl_path="actors/items/powerup_morphball/models/powerup_morphball.bcmdl",
        dependencies=(
            "actors/items/powerup_morphball/models/powerup_morphball.bcmdl",
            "actors/items/powerup_morphball/models/textures/powerup_morphball_d.bctex",
        ),
    ),
    "powerup_bomb": ModelData(
        bcmdl_path="actors/items/powerup_bomb/models/powerup_bomb.bcmdl",
        dependencies=(
            "actors/items/powerup_bomb/models/powerup_bomb.bcmdl",
            "actors/items/powerup_bomb/models/textures/powerup_bomb.bctex",
        ),
    ),
    "powerup_springball": ModelData(
        bcmdl_path="actors/items/powerup_springball/models/powerup_springball.bcmdl",
        dependencies=(
            "actors/items/powerup_springball/models/powerup_springball.bcmdl",
            "actors/items/powerup_springball/models/textures/itemspringball_d.bctex",
        ),
    ),
    "powerup_spiderball": ModelData(
        bcmdl_path="actors/items/powerup_spiderball/models/powerup_spiderball.bcmdl",
        dependencies=(
            "actors/items/powerup_spiderball/models/powerup_spiderball.bcmdl",
            "actors/items/powerup_spiderball/models/textures/powerup_morphball_d.bctex",
        ),
    ),
    "powerup_highjumpboots": ModelData(
        bcmdl_path="actors/items/powerup_highjumpboots/models/powerup_highjumpboots.bcmdl",
        dependencies=(
            "actors/items/powerup_highjumpboots/models/powerup_highjumpboots.bcmdl",
            "actors/items/powerup_highjumpboots/models/textures/itemspherehighjumpboots_d.bctex",
        ),
    ),
    "powerup_spacejump": ModelData(
        bcmdl_path="actors/items/powerup_spacejump/models/powerup_spacejump.bcmdl",
        dependencies=(
            "actors/items/powerup_spacejump/models/powerup_spacejump.bcmdl",
            "actors/items/powerup_spacejump/models/textures/itemspacejump_d.bctex",
            "maps/textures/cube5.bctex",
            "maps/textures/cube00.bctex",
        ),
    ),
    "powerup_screwattack": ModelData(
        bcmdl_path="actors/items/powerup_screwattack/models/powerup_screwattack.bcmdl",
        dependencies=(
            "actors/items/powerup_screwattack/models/powerup_screwattack.bcmdl",
            "actors/items/powerup_screwattack/models/textures/itemscrewattack_d.bctex",
        ),
    ),
    "item_energytank": ModelData(
        bcmdl_path="actors/items/item_energytank/models/item_energytank.bcmdl",
        dependencies=(
            "actors/items/item_energytank/models/item_energytank.bcmdl",
            "actors/items/item_energytank/models/textures/energytank_d.bctex",
            "actors/items/item_energytank/models/textures/tankglow.bctex",
            "actors/items/item_energytank/models/textures/weaponstank_d.bctex",
        ),
    ),
    "item_senergytank": ModelData(
        bcmdl_path="actors/items/item_senergytank/models/item_senergytank.bcmdl",
        dependencies=(
            "actors/items/item_senergytank/models/item_senergytank.bcmdl",
            "actors/items/item_energytank/models/item_energytank.bcmdl",
            "actors/items/item_senergytank/models/textures/spenergytank_d.bctex",
        ),
    ),
    "item_missiletank": ModelData(
        bcmdl_path="actors/items/item_missiletank/models/item_missiletank.bcmdl",
        dependencies=(
            "actors/items/item_missiletank/models/item_missiletank.bcmdl",
            "actors/items/item_energytank/models/item_energytank.bcmdl",
        ),
    ),
    "item_supermissiletank": ModelData(
        bcmdl_path="actors/items/item_supermissiletank/models/item_supermissiletank.bcmdl",
        dependencies=(
            "actors/items/item_supermissiletank/models/item_supermissiletank.bcmdl",
            "actors/items/item_energytank/models/item_energytank.bcmdl",
        ),
    ),
    "item_powerbombtank": ModelData(
        bcmdl_path="actors/items/item_powerbombtank/models/item_powerbombtank.bcmdl",
        dependencies=(
            "actors/items/item_powerbombtank/models/item_powerbombtank.bcmdl",
            "actors/items/item_energytank/models/item_energytank.bcmdl",
            "maps/textures/powerbomb_d.bctex",
            "actors/weapons/powerbomb/models/textures/powerbomb_d.bctex",
        ),
    ),
    "powerup_powerbomb": ModelData(
        bcmdl_path="actors/items/powerup_powerbomb/models/powerup_powerbomb.bcmdl",
        dependencies=(
            "actors/items/powerup_powerbomb/models/powerup_powerbomb.bcmdl",
            "actors/items/powerup_powerbomb/models/textures/powerbomb_d.bctex",
        ),
    ),
    "powerup_missilelauncher": ModelData(
        bcmdl_path="actors/items/powerup_missilelauncher/models/powerup_missilelauncher.bcmdl",
        dependencies=(
            "actors/items/powerup_missilelauncher/models/powerup_missilelauncher.bcmdl",
            "actors/items/powerup_missilelauncher/models/textures/missile_e.bctex",
        ),
    ),
    "offworld_generic": ModelData(
        bcmdl_path="actors/items/offworld_generic/models/offworld_generic.bcmdl",
        dependencies=(
            "actors/items/offworld_generic/models/offworld_generic.bcmdl",
            "maps/textures/chozoartifactor_o.bctex",
        ),
    ),
    "offworld_icemissile": ModelData(
        bcmdl_path="actors/items/offworld_icemissile/models/offworld_icemissile.bcmdl",
        dependencies=(
            "actors/items/offworld_icemissile/models/offworld_icemissile.bcmdl",
            "actors/items/offworld_icemissile/models/textures/missile_d.bctex",
        ),
    ),
    "offworld_powergrip": ModelData(
        bcmdl_path="actors/items/offworld_powergrip/models/offworld_powergrip.bcmdl",
        dependencies=(
            "actors/items/offworld_powergrip/models/offworld_powergrip.bcmdl",
            "actors/items/offworld_powergrip/models/textures/itempowergrip_d.bctex",
        ),
    ),
    "offworld_speedbooster": ModelData(
        bcmdl_path="actors/items/offworld_speedbooster/models/offworld_speedbooster.bcmdl",
        dependencies=(
            "actors/items/offworld_speedbooster/models/offworld_speedbooster.bcmdl",
            "maps/textures/chozoartifactor_s.bctex",
        ),
    ),
    "offworld_missile": ModelData(
        bcmdl_path="actors/items/offworld_missile/models/offworld_missile.bcmdl",
        dependencies=(
            "actors/items/offworld_missile/models/offworld_missile.bcmdl",
            "actors/items/offworld_missile/models/textures/missile_d.bctex",
        ),
    ),
    "offworld_beam": ModelData(
        bcmdl_path="actors/items/offworld_beam/models/offworld_beam.bcmdl",
        dependencies=(
            "actors/items/offworld_beam/models/offworld_beam.bcmdl",
            "actors/items/offworld_beam/models/textures/offworldbeam_d.bctex",
        ),
    ),
    "offworld_suit": ModelData(
        bcmdl_path="actors/items/offworld_suit/models/offworld_suit.bcmdl",
        dependencies=(
            "actors/items/offworld_suit/models/offworld_suit.bcmdl",
            "actors/items/offworld_suit/models/textures/offworldsuit_d.bctex",
        ),
    ),
}


def get_data(name: str) -> ModelData:
    return ALL_MODEL_DATA.get(name, ALL_MODEL_DATA["itemsphere"])
