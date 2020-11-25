function fish_prompt
    fish --command "
    set -g _tide_last_pipestatus $pipestatus
    set -g _tide_last_status $status
    set -g _tide_fish_pid $fish_pid
    
    test -n \"$SSH_TTY\" && set -g SSH_TTY
    set COLUMNS $COLUMNS
    set CMD_DURATION $CMD_DURATION

    command kill $_tide_last_pid 2>/dev/null
    set -U _tide_left_prompt_display_$fish_pid (_tide_prompt)" &

    set -g _tide_last_pid (jobs --last --pid)
    disown

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