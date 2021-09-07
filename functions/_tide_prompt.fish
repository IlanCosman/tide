function _tide_prompt
    left_prompt=(_tide_left_prompt) right_prompt=(_tide_right_prompt) if set -q left_prompt[2] # If prompt is two lines
        if test "$tide_left_prompt_frame_enabled" = true
            set left_prompt[1] $_tide_prompt_and_frame_color╭─"$left_prompt[1]"
            set left_prompt[2] $_tide_prompt_and_frame_color╰─"$left_prompt[2]"
        end
        if test "$tide_right_prompt_frame_enabled" = true
            set right_prompt[1] "$right_prompt[1]"$_tide_prompt_and_frame_color─╮
            set right_prompt[2] "$right_prompt[2]"$_tide_prompt_and_frame_color─╯
        end

        echo $right_prompt[2]

        set -lx dist_btwn_sides (math $COLUMNS + 5 - ( # Regex removes color. 5 = @PWD@ length which will be replaced
            string replace -ar '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$left_prompt[1]""$right_prompt[1]" | string length))
        printf '%s' (string replace @PWD@ (_tide_pwd) "$left_prompt[1]") $_tide_prompt_and_frame_color

        string repeat --no-newline --max (math max 0, $dist_btwn_sides - $pwd_length) $tide_prompt_icon_connection
        printf '%s' $right_prompt[1] \n $left_prompt[2]' '
    else
        echo $right_prompt[1]

        set -lx dist_btwn_sides (math $COLUMNS + 5 -$tide_prompt_min_cols - (
            string replace -ar '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$left_prompt[1]""$right_prompt[1]" | string length))
        string replace @PWD@ (_tide_pwd) "$left_prompt[1] "
    end
end

function _tide_left_prompt
    set -g _tide_last_item_was_newline

    _tide_which_side_working_on=left for item in $tide_left_prompt_items
        _tide_item_$item
    end

    if not set -e _tide_last_item_was_newline
        set_color $_tide_previous_bg_color -b normal
        printf '%s' $tide_left_prompt_suffix
    end

    set_color normal # Make sure there is something printed on the last line
end

function _tide_right_prompt
    set -g _tide_last_item_was_newline

    _tide_which_side_working_on=right for item in $tide_right_prompt_items
        _tide_item_$item
    end

    if not set -e _tide_last_item_was_newline
        set_color $_tide_previous_bg_color -b normal
        printf '%s' $tide_right_prompt_suffix
    end

    set_color normal # Make sure there is something printed on the last line
end

function _tide_item_pwd
    _tide_print_item pwd @PWD@
end
