# external/

This directory contains the tools needed to compile the native 3DS code patch
(`msr-remote-connector`) and regenerate the IPS patch files used by the randomizer.

## Setup

### 1. Python dependencies

Use the root project's virtual environment and install the extra dependency
required by `magikoopa-py`:

```sh
pip install -r magikoopa-py/requirements.txt
```

The root project's `ips.py` dependency (declared in `pyproject.toml`) is also
required for the IPS patch generation step; it is already present if you
installed the project normally.

### 2. devkitARM toolchain

Follow the [magikoopa-py README](magikoopa-py/README.md) for instructions on
installing devkitPro / devkitARM and setting the required environment variables
(`DEVKITPRO`, `DEVKITARM`, `PORTLIBS_PATH`).

### 3. Game files

Copy the **unmodified** game files into `msr-remote-connector/`:

```
external/msr-remote-connector/
├── code.bin       ← copy from the game's ExeFS
└── exheader.bin   ← copy from the game's ExeFS
```

On the first `insert` run, Magikoopa will automatically back these up to
`msr-remote-connector/bak/` and use those backups as the source of truth for
all subsequent runs.

## Building

Run the build script from the repository root (or from within `external/`):

```sh
python external/build_patches.py
```

This will:
1. Compile `msr-remote-connector` and inject it into `code.bin` / `exheader.bin`
   via `magikoopa-py`.
2. Regenerate the IPS patch files in
   `src/open_samus_returns_rando/files/exefs_patches/` from the patched binaries.
