_tide_detect_os

# Set things that wont change
set -g _tide_left_prompt_display_var _tide_left_prompt_display_$fish_pid

set -gx _tide_fish_pid $fish_pid

function fish_prompt
    set -lx _tide_last_pipestatus $pipestatus

    if not set -e _tide_repainting
        set -lx _tide_jobs_number (jobs --pid | count)

        fish --command "
        set CMD_DURATION $CMD_DURATION
        set COLUMNS $COLUMNS
        set fish_bind_mode $fish_bind_mode
        set fish_term24bit $fish_term24bit

        command kill $_tide_last_pid 2>/dev/null
        set -U _tide_left_prompt_display_$fish_pid (_tide_prompt)
        " >&- & # >&- closes stdout. See https://github.com/fish-shell/fish-shell/issues/7559

        set -g _tide_last_pid (jobs --last --pid)
        disown $_tide_last_pid 2>/dev/null
    end

    string unescape $$_tide_left_prompt_display_var
end

function _tide_refresh_prompt --on-variable _tide_left_prompt_display_$fish_pid --on-variable _tide_right_prompt_display_$fish_pid
    set -g _tide_repainting
    commandline --function force-repaint
end

# Double underscores to avoid erasing this function on uninstall
function __tide_on_fish_exit --on-event fish_exit
    set -e _tide_left_prompt_display_$fish_pid
    set -e _tide_right_prompt_display_$fish_pid
end