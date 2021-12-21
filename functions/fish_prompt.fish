function fish_prompt
end

status is-interactive || exit

_tide_remove_unusable_items
_tide_cache_variables

# The first element in $$_tide_prompt_var is right prompt
# All remaining ones are 'left' prompt (also upper right in 2-line prompts)
set -g _tide_prompt_var _tide_prompt_$fish_pid
set -U $_tide_prompt_var # So that if we erase $_tide_prompt_var, the bg job can't set a uvar

# _tide_repaint prevents us from creating a second background job
function _tide_refresh_prompt --on-variable $_tide_prompt_var
    set -g _tide_repaint
    commandline -f repaint
end

eval "
function fish_prompt
    _tide_status=\$status _tide_pipestatus=\$pipestatus if not set -e _tide_repaint
        jobs -q && set -lx _tide_jobs
        fish -c \"set _tide_pipestatus \$_tide_pipestatus
CMD_DURATION=\$CMD_DURATION COLUMNS=\$COLUMNS fish_bind_mode=\$fish_bind_mode \
set $_tide_prompt_var ($_tide_X_line_prompt)\" &
        builtin disown

        command kill \$_tide_last_pid 2>/dev/null
        set -g _tide_last_pid \$last_pid
    end

    string unescape $_tide_add_newline \$$_tide_prompt_var[1][2..]
end

function fish_right_prompt
    string unescape \$$_tide_prompt_var[1][1]
end

function _tide_on_fish_exit --on-event fish_exit
    set -e $_tide_prompt_var
end"

set -e _tide_prompt_var _tide_X_line_prompt _tide_add_newline
