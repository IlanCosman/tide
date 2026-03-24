status is-interactive || exit
test "$VSCODE_INJECTION" = 1 || exit

# Capture the real post-command state before VSCode's prompt hooks mutate it,
# so Tide can render accurate status and cmd_duration items on the next prompt.
function _tide_vscode_capture_postexec --on-event fish_postexec
    set -g _tide_vscode_had_cmd 1
    set -g _tide_vscode_status $status
    set -g _tide_vscode_pipestatus $pipestatus
    set -g _tide_vscode_cmd_duration $CMD_DURATION
end

# Fish's clear-screen reader function does not go through VSCode's normal
# command lifecycle hooks, so refresh VSCode's prompt markers after Ctrl+L to
# avoid sticky-command spacing glitches.
function _tide_vscode_clear_screen
    commandline -f clear-screen
    functions --query __vsc_update_cwd && __vsc_update_cwd
end

bind ctrl-l _tide_vscode_clear_screen

# VSCode's wrapper is installed after startup, so wait until it exists before
# replacing fish_prompt with Tide's newline-safe wrapper.
function _tide_vscode_fix_prompt --on-event fish_prompt
    _tide_vscode_wrap_prompt || return
    functions --erase _tide_vscode_fix_prompt
end
