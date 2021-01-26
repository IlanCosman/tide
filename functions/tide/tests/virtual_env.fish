# RUN: %fish %s

function _virtual_env
    _tide_decolor (_tide_item_virtual_env)
end

set -lx VIRTUAL_ENV

_virtual_env # CHECK:

set -lx VIRTUAL_ENV ~/python_project/.venv
set -lx tide_virtual_env_icon ''

set -lx tide_virtual_env_display_mode projectName
_virtual_env # CHECK:  python_project

set -lx tide_virtual_env_display_mode venvName
_virtual_env # CHECK:  .venv

set -lx tide_virtual_env_icon
set -lx tide_virtual_env_display_mode projectName
_virtual_env # CHECK: python_project
