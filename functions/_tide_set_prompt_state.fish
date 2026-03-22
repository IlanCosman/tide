function _tide_set_prompt_state
    set -l tide_status $status
    set -l tide_pipestatus $pipestatus
    set -l tide_cmd_duration $CMD_DURATION

    # VSCode shell integration can reset $status before Tide renders and emits
    # a synthetic command-finished marker on empty prompts, so reuse the last
    # real postexec state or fall back to a clean prompt state.
    if test "$VSCODE_INJECTION" = 1
        if set -q _tide_vscode_had_cmd
            set -g _tide_status $_tide_vscode_status
            set -g _tide_pipestatus $_tide_vscode_pipestatus
            set -g _tide_cmd_duration $_tide_vscode_cmd_duration
            set -e _tide_vscode_had_cmd
        else
            set -g _tide_status 0
            set -g _tide_pipestatus 0
            set -g _tide_cmd_duration 0
        end
    else
        set -g _tide_status $tide_status
        set -g _tide_pipestatus $tide_pipestatus
        set -g _tide_cmd_duration $tide_cmd_duration
    end
end
