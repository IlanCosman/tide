@mesg '---------virtual_env---------'

function _virtual_env
    _tide_decolor (_tide_item_virtual_env)
end

set -l dir ~/python_project

mkdir -p $dir
cd $dir

@test 'nothing' (_virtual_env) -z

python3 -m venv .venv
source .venv/bin/activate.fish

set -lx tide_virtual_env_icon ''

set -lx tide_virtual_env_display_mode projectName
@test 'projectName' (_virtual_env) = " python_project"

set -lx tide_virtual_env_display_mode venvName
@test 'venvName' (_virtual_env) = " .venv"

set -lx tide_virtual_env_icon
set -lx tide_virtual_env_display_mode projectName
@test 'No icon' (_virtual_env) = "python_project"

rm -r $dir