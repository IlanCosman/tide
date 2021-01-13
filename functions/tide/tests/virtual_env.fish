@echo '---------virtual_env---------'

function _virtual_env
    _tide_decolor (_tide_item_virtual_env)
end

set -lx VIRTUAL_ENV

@test 'nothing' -z (_virtual_env)

set -lx VIRTUAL_ENV ~/python_project/.venv
set -lx tide_virtual_env_icon ''

set -lx tide_virtual_env_display_mode projectName
@test 'projectName' (_virtual_env) = " python_project"

set -lx tide_virtual_env_display_mode venvName
@test 'venvName' (_virtual_env) = " .venv"

set -lx tide_virtual_env_icon
set -lx tide_virtual_env_display_mode projectName
@test 'No icon' (_virtual_env) = "python_project"