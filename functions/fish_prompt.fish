function fish_prompt
end

status is-interactive || exit

_tide_remove_unusable_items

set -g _tide_left_prompt_display_var _tide_left_prompt_display_$fish_pid
set -gx _tide_right_prompt_display_var _tide_right_prompt_display_$fish_pid

function _tide_refresh_prompt --on-variable $_tide_left_prompt_display_var --on-variable $_tide_right_prompt_display_var
    set -g _tide_self_repainting # prevents us from creating a second background job
    commandline --function repaint
end

function fish_prompt
    set -lx _tide_last_status $status
    set -lx _tide_last_pipestatus $pipestatus

    if not set -e _tide_self_repainting
        _tide_jobs_number=(jobs --pid | count) fish --command "
            set -g CMD_DURATION $CMD_DURATION
            set -g COLUMNS $COLUMNS
            set -g fish_bind_mode $fish_bind_mode
            set -g fish_term24bit $fish_term24bit
            set -U $_tide_left_prompt_display_var (_tide_prompt)" &

        command kill $_tide_last_pid 2>/dev/null
        set -g _tide_last_pid (jobs --last --pid) # Replace with $last_pid in Fish 3.3.0
        builtin disown $_tide_last_pid 2>/dev/null
    end

    string unescape $$_tide_left_prompt_display_var
end

# Double underscores to avoid erasing this function on uninstall
function __tide_on_fish_exit --on-event fish_exit
    set -e $_tide_left_prompt_display_var $_tide_right_prompt_display_var
end
