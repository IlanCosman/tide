function fish_prompt
end

status is-interactive || exit

_tide_remove_unusable_items
_tide_cache_variables

# The first element in $$_tide_prompt_var is right prompt
# All remaining ones are 'left' prompt (also upper right in 2-line prompts)
set -l _tide_prompt_var _tide_prompt_$fish_pid
set -U $_tide_prompt_var # So that if we erase $_tide_prompt_var, the bg job can't set a uvar

# _tide_repaint prevents us from creating a second background job
function _tide_refresh_prompt --on-variable $_tide_prompt_var
    set -g _tide_repaint
    commandline -f repaint
end

if contains newline $_tide_left_items
    test "$tide_prompt_add_newline_before" = true && set -l _tide_add_newline '\n'

    set_color $tide_prompt_color_frame_and_connection -b normal | read -l _tide_prompt_and_frame_color

    set -l column_offset 5

    test "$tide_left_prompt_frame_enabled" = true &&
        set -l top_left_frame "$_tide_prompt_and_frame_color╭─" &&
        set -l bot_left_frame "$_tide_prompt_and_frame_color╰─" &&
        set column_offset (math $column_offset-2)
    test "$tide_right_prompt_frame_enabled" = true &&
        set -l top_right_frame "$_tide_prompt_and_frame_color─╮" &&
        set -l bot_right_frame "$_tide_prompt_and_frame_color─╯" &&
        set column_offset (math $column_offset-2)

    eval "
function fish_prompt
    _tide_status=\$status _tide_pipestatus=\$pipestatus if not set -e _tide_repaint
        jobs -q && set -lx _tide_jobs
        fish -c \"set _tide_pipestatus \$_tide_pipestatus
CMD_DURATION=\$CMD_DURATION fish_bind_mode=\$fish_bind_mode set $_tide_prompt_var (_tide_2_line_prompt)\" &
        builtin disown

        command kill \$_tide_last_pid 2>/dev/null
        set -l _tide_last_pid \$last_pid
    end

    math \$COLUMNS-(string length --visible \"\$$_tide_prompt_var[1][2]\$$_tide_prompt_var[1][3]\")+$column_offset | read -lx dist_btwn_sides

    echo -ns $_tide_add_newline(string replace @PWD@ (_tide_pwd) \"$top_left_frame\$$_tide_prompt_var[1][2]\")'$_tide_prompt_and_frame_color'
    string repeat --no-newline --max (math max 0, \$dist_btwn_sides-\$pwd_length) '$tide_prompt_icon_connection'
    echo -ns \"\$$_tide_prompt_var[1][3]$top_right_frame\"\n\"$bot_left_frame\$$_tide_prompt_var[1][4] \"
end"
else
    test "$tide_prompt_add_newline_before" = true && set -l _tide_add_newline '\0'

    math 5 -$tide_prompt_min_cols | read -l column_offset
    test $column_offset -ge 0 && set column_offset "+$column_offset"

    eval "
function fish_prompt
    _tide_status=\$status _tide_pipestatus=\$pipestatus if not set -e _tide_repaint
        jobs -q && set -lx _tide_jobs
        fish -c \"set _tide_pipestatus \$_tide_pipestatus
CMD_DURATION=\$CMD_DURATION fish_bind_mode=\$fish_bind_mode set $_tide_prompt_var (_tide_1_line_prompt)\" &
        builtin disown

        command kill \$_tide_last_pid 2>/dev/null
        set -l _tide_last_pid \$last_pid
    end

    math \$COLUMNS-(string length --visible \"\$$_tide_prompt_var[1][2]\$$_tide_prompt_var[1][3]\")$column_offset | read -lx dist_btwn_sides
    string replace @PWD@ (_tide_pwd) $_tide_add_newline \$$_tide_prompt_var[1][2]' '
end"
end

eval "
function fish_right_prompt
    string unescape \$$_tide_prompt_var[1][1]$bot_right_frame
end

function _tide_on_fish_exit --on-event fish_exit
    set -e $_tide_prompt_var
end"
