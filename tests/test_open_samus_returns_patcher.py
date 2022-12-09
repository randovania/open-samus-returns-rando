from unittest.mock import MagicMock

from open_samus_returns_rando import samus_returns_patcher


def test_create_init_copy_exists():
    editor = MagicMock()
    editor.does_asset_exists.return_value = True

    # Run
    samus_returns_patcher.create_init_copy(editor)
    samus_returns_patcher.create_scenario_copy(editor)

    # Assert
    editor.does_asset_exists.assert_called_once_with("system/scripts/original_init.lc")
    editor.does_asset_exists.assert_called_once_with("system/scripts/scenario_init.lc")
    editor.add_new_asset.assert_not_called()