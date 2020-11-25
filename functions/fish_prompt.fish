function fish_prompt --description 'Created by tide configure'
    set -lx _tide_last_pipestatus $pipestatus
    set -lx _tide_last_status $status
    set -lx _tide_fish_pid $fish_pid # User for right prompt

    set -lx COLUMNS $COLUMNS
    set -q SSH_TTY && set -lx SSH_TTY $SSH_TTY
    set -lx _tide_cmd_duration $CMD_DURATION

    fish --command "set -U _tide_left_prompt_display_$fish_pid (_tide_prompt)" &

    set -l displayVarName _tide_left_prompt_display_$fish_pid
    string unescape $$displayVarName
end

function _tide_refresh_prompt --on-variable _tide_left_prompt_display_$fish_pid
    commandline --function repaint
end

function _tide_on_fish_exit --on-even fish_exit
    set -e _tide_left_prompt_display_$fish_pid
    set -e _tide_right_prompt_display_$fish_pid
end