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

# Support for poetry virtualenvs
set -lx _OLD_VIRTUAL_PATH /some /paths # set by poetry
set -lx VIRTUAL_ENV /home/user/.cache/pypoetry/virtualenvs/project-j_EVlIcP-py3.8
_virtual_env # CHECK: project
set -lx VIRTUAL_ENV /home/user/.cache/pypoetry/virtualenvs/some-project-j_EVlIcP-py3.8
_virtual_env # CHECK: some-project

# Support for conda virtualenvs
set -lx VIRTUAL_ENV
set -lx CONDA_DEFAULT_ENV base
_virtual_env # CHECK: base
