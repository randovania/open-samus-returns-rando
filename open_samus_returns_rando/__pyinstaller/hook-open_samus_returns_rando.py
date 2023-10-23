from PyInstaller.utils.hooks import collect_data_files

# https://pyinstaller.readthedocs.io/en/stable/hooks.html#provide-hooks-with-package

datas = collect_data_files('open_samus_returns_rando', excludes=['__pyinstaller'])
