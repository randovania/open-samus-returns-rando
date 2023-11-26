# Open Samus Returns Rando
Open Source randomizer patcher for Metroid: Samus Returns. Intended for use in [Randovania](https://github.com/randovania).
Currently supports patching the following:
- Starting items
- Starting location
- Pickups
- Items on Metroids
- Shuffled DNA/Baby Metroid

## Installation
`pip install open-samus-returns-rando`

This repository uses [pre-commit](https://pre-commit.com/). 
```
pip install pre-commit
pre-commit install
```

## Usage
You will need to provide JSON data matching the [JSON schema](https://github.com/randovania/src/open-samus-returns-rando/blob/main/open_samus_returns_rando/files/schema.json) in order to successfully patch the game.

The patcher expects a path to an extracted romfs directory of Metroid: Samus Returns as well as the desired output directory. Output files are in a format compatible with either Luma3DS or Citra.

With a JSON file:
`python -m open-samus-returns-rando --input-path path/to/samus-returns/romfs --output-path path/to/the/output/mod --input-json path/to/patcher-config.json`
