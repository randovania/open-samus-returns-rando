import os

# Functions
# =========
#
# .. _get_hook_dirs:
#
# get_hook_dirs
# -------------
#
# Tell PyInstaller where to find hooks provided by this distribution;
# this is referenced by the :ref:`hook registration <hook_registration>`.
# This function returns a list containing only the path to this
# directory, which is the location of these hooks.

def get_hook_dirs():
    return [os.path.dirname(__file__)] # noqa: PTH120
