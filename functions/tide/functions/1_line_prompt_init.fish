cat $dirname/tide/functions/_tide_1_line_prompt.fish |
    string replace "# @ left side goes here @" $leftPromptItemCode |
    string replace "# @ right side goes here @" $rightPromptItemCode >$dirname/tide/prompt.fish

test "$tide_prompt_add_newline_before" = true && set -l add_newline '\0'

math 5 -$tide_prompt_min_cols | read -l column_offset
test $column_offset -ge 0 && set column_offset "+$column_offset"

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

    math \$COLUMNS-(string length -V \"\$$prompt_var[1][1]\$$prompt_var[1][2]\")$column_offset | read -lx dist_btwn_sides
    string replace @PWD@ (_tide_pwd) $add_newline \$$prompt_var[1][1]'$color_normal '
end

function fish_right_prompt
    string unescape \"\$$prompt_var[1][2]$color_normal\"
end"
