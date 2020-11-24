function fish_prompt --description 'Created by tide configure'
    set -lx _tide_last_pipestatus $pipestatus
    set -lx _tide_last_status $status

    set -lx COLUMNS $COLUMNS
    set -q SSH_TTY && set -lx SSH_TTY $SSH_TTY
    set -lx _tide_cmd_duration $CMD_DURATION

    fish --command 'set -U _tide_left_prompt_display (_tide_prompt)' &

    string unescape $_tide_left_prompt_display
end

function _tide_refresh_prompt --on-variable _tide_left_prompt_display --on-variable _tide_right_prompt_display
    commandline --function repaint
end