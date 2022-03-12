cat $dirname/tide/functions/_tide_2_line_prompt.fish |
    string replace "# @ left side goes here @" $leftPromptItemCode |
    string replace "# @ right side goes here @" $rightPromptItemCode >$dirname/tide/prompt.fish

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
CMD_DURATION=\$CMD_DURATION fish_bind_mode=\$fish_bind_mode set $prompt_var (source $dirname/tide/prompt.fish)\" &
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
