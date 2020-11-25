function fish_prompt
    set -lx _tide_last_pipestatus $pipestatus
    set -lx _tide_last_status $status
    set -lx _tide_fish_pid $fish_pid # Used for right prompt

    set -lx COLUMNS $COLUMNS
    set -q SSH_TTY && set -lx SSH_TTY $SSH_TTY
    set -lx _tide_cmd_duration $CMD_DURATION

    fish --command "command kill $_tide_last_pid 2>/dev/null; set -U _tide_left_prompt_display_$fish_pid (_tide_prompt)" &
    set -g _tide_last_pid (jobs --last --pid)

    set -l displayVarName _tide_left_prompt_display_$fish_pid
    string unescape $$displayVarName
end

function _tide_refresh_prompt --on-variable _tide_left_prompt_display_$fish_pid
    commandline --function repaint
end

function _tide_on_fish_exit --on-event fish_exit
    set -e _tide_left_prompt_display_$fish_pid
    set -e _tide_right_prompt_display_$fish_pid
end