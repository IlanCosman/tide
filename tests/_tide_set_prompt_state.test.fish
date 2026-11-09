# RUN: %fish %s

function _show_prompt_state
    _tide_set_prompt_state
    echo $_tide_status\|(string join , $_tide_pipestatus)\|$_tide_cmd_duration
end

set -e VSCODE_INJECTION _tide_vscode_had_cmd _tide_vscode_status _tide_vscode_pipestatus _tide_vscode_cmd_duration

set -gx CMD_DURATION 123
false
_show_prompt_state # CHECK: 1|1|123

set -gx CMD_DURATION 456
true | false
_show_prompt_state # CHECK: 1|0,1|456

set -gx VSCODE_INJECTION 1
set -g _tide_vscode_had_cmd 1
set -g _tide_vscode_status 7
set -g _tide_vscode_pipestatus 0 7
set -g _tide_vscode_cmd_duration 789
_show_prompt_state # CHECK: 7|0,7|789
_show_prompt_state # CHECK: 0|0|0
