# RUN: %fish %s
_tide_parent_dirs

function _python
    _tide_decolor (_tide_item_python)
end

set -lx tide_python_icon 
mock python --version "echo 'Python 3.11.5'"

set -lx VIRTUAL_ENV
_python # CHECK:

set -lx VIRTUAL_ENV /home/ilan/python_project/non-generic-name
_python # CHECK:  3.11.5 (non-generic-name)

set -lx VIRTUAL_ENV /home/ilan/python_project/venv
_python # CHECK:  3.11.5 (python_project)

set -lx VIRTUAL_ENV /home/ilan/.local/share/virtualenvs/pipenv_project-EwRYuc3l
_python # CHECK:  3.11.5 (pipenv_project)

set -l python_directory (mktemp -d)
cd $python_directory

set -lx VIRTUAL_ENV
echo >requirements.txt
_python # CHECK:  3.11.5
