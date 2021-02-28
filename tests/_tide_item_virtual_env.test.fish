# RUN: %fish %s

function _virtual_env
    _tide_decolor (_tide_item_virtual_env)
end

set -lx tide_virtual_env_icon ''

set -lx VIRTUAL_ENV
_virtual_env # CHECK:

set -lx VIRTUAL_ENV ~/python_project/non-generic-name
_virtual_env # CHECK:  non-generic-name

set -lx VIRTUAL_ENV ~/python_project/venv
_virtual_env # CHECK:  python_project
