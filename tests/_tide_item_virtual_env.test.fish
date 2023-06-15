# RUN: %fish %s
_tide_parent_dirs

function _virtual_env
    _tide_decolor (_tide_item_virtual_env)
end

mock python --version "echo Python 3.11.3"
set -lx tide_virtual_env_icon 

set -lx VIRTUAL_ENV
_virtual_env # CHECK:

set -lx VIRTUAL_ENV /home/ilan/python_project/non-generic-name
_virtual_env # CHECK:  3.11.3 (non-generic-name)

set -lx VIRTUAL_ENV /home/ilan/python_project/venv
_virtual_env # CHECK:  3.11.3 (python_project)

set -lx VIRTUAL_ENV /home/ilan/.local/share/virtualenvs/pipenv_project-EwRYuc3l
_virtual_env # CHECK:  3.11.3 (pipenv_project)
