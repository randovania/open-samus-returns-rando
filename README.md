# Open Samus Returns Rando
Open Source randomizer patcher for Metroid: Samus Returns. Intended for use in [Randovania](https://github.com/randovania).
Currently supports patching starting items.

## Installation
`pip install open-samus-returns-rando`

## Usage
You will need to provide JSON data matching the [JSON schema](https://github.com/randovania/open-samus-returns-rando/blob/main/open_samus_returns_rando/files/schema.json) in order to successfully patch the game. 

The patcher expects a path to an extracted romfs directory of Metroid: Samus Returns as well as the desired output directory.

With a JSON file:
`python -m open-samus-returns-rando --input-path ~/samus_returns/romfs --output-path ~/your-ryujinx-mod-folder/rando --input-json ~/samus_returnsrando/patcher.json`

From stdin:
`python -m open-samus-returns-rando --input-path ~/samus_returns/romfs --output-path ~/your-ryujinx-mod-folder/rando`
