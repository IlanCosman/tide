function fish_prompt
end # In case this file gets loaded non-interactively, e.g by conda
status is-interactive || exit

_tide_remove_unusable_items
_tide_cache_variables
source (functions --details _tide_pwd)

set -l prompt_var _tide_prompt_$fish_pid
set -U $prompt_var # Set var here so if we erase $prompt_var, bg job won't set a uvar

set_color normal | read -l color_normal
status fish-path | read -l fish_path

# _tide_repaint prevents us from creating a second background job
function _tide_refresh_prompt --on-variable $prompt_var --on-variable COLUMNS
    set -g _tide_repaint
    commandline -f repaint
end

if contains newline $_tide_left_items # two line prompt initialization
    test "$tide_prompt_add_newline_before" = true && set -l add_newline '\n'

    set_color $tide_prompt_color_frame_and_connection -b normal | read -l prompt_and_frame_color

    set -l column_offset 5
    test "$tide_left_prompt_frame_enabled" = true &&
        set -l top_left_frame "$prompt_and_frame_color╭─" &&
        set -l bot_left_frame "$prompt_and_frame_color╰─" &&
        set column_offset (math $column_offset-2)
    test "$tide_right_prompt_frame_enabled" = true &&
        set -l top_right_frame "$prompt_and_frame_color─╮" &&
        set -l bot_right_frame "$prompt_and_frame_color─╯" &&
        set column_offset (math $column_offset-2)

    eval "
function fish_prompt
    _tide_status=\$status _tide_pipestatus=\$pipestatus if not set -e _tide_repaint
        jobs -q && set -lx _tide_jobs
        $fish_path -c \"set _tide_pipestatus \$_tide_pipestatus
CMD_DURATION=\$CMD_DURATION fish_bind_mode=\$fish_bind_mode set $prompt_var (_tide_2_line_prompt)\" &
        builtin disown

        command kill \$_tide_last_pid 2>/dev/null
        set -g _tide_last_pid \$last_pid
    end

    math \$COLUMNS-(string length -V \"\$$prompt_var[1][1]\$$prompt_var[1][3]\")+$column_offset | read -lx dist_btwn_sides

    echo -ns $add_newline'$top_left_frame'(string replace @PWD@ (_tide_pwd) \"\$$prompt_var[1][1]\")'$prompt_and_frame_color'
    string repeat -Nm(math max 0, \$dist_btwn_sides-\$_tide_pwd_len) '$tide_prompt_icon_connection'
    echo -ns \"\$$prompt_var[1][3]$top_right_frame\"\n\"$bot_left_frame\$$prompt_var[1][2]$color_normal \"
end

function fish_right_prompt
    string unescape \"\$$prompt_var[1][4]$bot_right_frame$color_normal\"
end"
else # one line prompt initialization
    test "$tide_prompt_add_newline_before" = true && set -l add_newline '\0'

    math 5 -$tide_prompt_min_cols | read -l column_offset
    test $column_offset -ge 0 && set column_offset "+$column_offset"

    eval "
function fish_prompt
    _tide_status=\$status _tide_pipestatus=\$pipestatus if not set -e _tide_repaint
        jobs -q && set -lx _tide_jobs
        $fish_path -c \"set _tide_pipestatus \$_tide_pipestatus
CMD_DURATION=\$CMD_DURATION fish_bind_mode=\$fish_bind_mode set $prompt_var (_tide_1_line_prompt)\" &
        builtin disown

        command kill \$_tide_last_pid 2>/dev/null
        set -g _tide_last_pid \$last_pid
    end

    math \$COLUMNS-(string length -V \"\$$prompt_var[1][1]\$$prompt_var[1][2]\")$column_offset | read -lx dist_btwn_sides
    string replace @PWD@ (_tide_pwd) $add_newline \$$prompt_var[1][1]'$color_normal '
end

function fish_right_prompt
    string unescape \"\$$prompt_var[1][2]$color_normal\"
end"
end

eval "function _tide_on_fish_exit --on-event fish_exit
    set -e $prompt_var
end"
