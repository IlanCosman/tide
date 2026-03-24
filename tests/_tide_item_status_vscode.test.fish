# RUN: %fish %s
_tide_parent_dirs

function _status
    set -lx _tide_status $status
    set -lx _tide_pipestatus $pipestatus
    _tide_decolor (_tide_item_status)
end

set -lx tide_status_icon ✔
set -lx tide_status_icon_failure ✘
set -lx _tide_left_items
set -lx VSCODE_INJECTION 1
set -e tide_status_show_in_vscode

# Hidden by default in VSCode shell integration.
false
_status # CHECK:

# Setting tide_status_show_in_vscode restores the usual Tide status item.
set -lx tide_status_show_in_vscode true

false
_status # CHECK: ✘ 1

true
_status # CHECK: ✔
