import os
from pathlib import Path

import pytest

_FAIL_INSTEAD_OF_SKIP = False

def get_env_or_skip(env_name):
    if env_name not in os.environ:
        if _FAIL_INSTEAD_OF_SKIP:
            pytest.fail(f"Missing environment variable {env_name}")
        else:
            pytest.skip(f"Skipped due to missing environment variable {env_name}")
    return os.environ[env_name]


@pytest.fixture(scope="session")
def samus_returns_roms_path():
    return Path(get_env_or_skip("SAMUS_RETURNS_PATH_ROMS"))

