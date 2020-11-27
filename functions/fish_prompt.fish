_tide_detect_os
_tide_git_prompt_set_vars

function fish_prompt
    set -lx _tide_last_pipestatus $pipestatus
    set -lx _tide_last_status $status
    set -lx _tide_jobs_number (jobs --pid | count)

    fish --command "
    set -g _tide_fish_pid $fish_pid
    
    set CMD_DURATION $CMD_DURATION
    set COLUMNS $COLUMNS
    set fish_bind_mode $fish_bind_mode
    set fish_term24bit $fish_term24bit

    command kill $_tide_last_pid 2>/dev/null
    set -U _tide_left_prompt_display_$fish_pid (_tide_prompt)" &

    set -g _tide_last_pid (jobs --last --pid)
    disown $_tide_last_pid 2>/dev/null

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