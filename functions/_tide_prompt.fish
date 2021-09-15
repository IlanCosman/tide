function _tide_prompt
    left_prompt=(_tide_left_prompt) right_prompt=(_tide_right_prompt) if set -q _tide_prompt_and_frame_color # If prompt is two lines
        if test "$tide_left_prompt_frame_enabled" = true
            set left_prompt[1] $_tide_prompt_and_frame_color╭─"$left_prompt[1]"
            set left_prompt[2] $_tide_prompt_and_frame_color╰─"$left_prompt[2]"
        end
        if test "$tide_right_prompt_frame_enabled" = true
            set right_prompt[1] "$right_prompt[1]"$_tide_prompt_and_frame_color─╮
            set right_prompt[2] "$right_prompt[2]"$_tide_prompt_and_frame_color─╯
        end

        # 5 = @PWD@ length which will be replaced
        math $COLUMNS+5-(string length --visible "$left_prompt[1]$right_prompt[1]") | read -lx dist_btwn_sides
        echo -ns $right_prompt[2] \n (string replace @PWD@ (_tide_pwd) "$left_prompt[1]") $_tide_prompt_and_frame_color

        string repeat --no-newline --max (math max 0, $dist_btwn_sides-$pwd_length) $tide_prompt_icon_connection
        echo -ns $right_prompt[1] \n $left_prompt[2]' '
    else
        math $COLUMNS+5-(string length --visible "$left_prompt[1]$right_prompt[1]") -$tide_prompt_min_cols | read -lx dist_btwn_sides
        string replace @PWD@ (_tide_pwd) "$right_prompt[1]" "$left_prompt[1] "
    end
end

function _tide_left_prompt
    set -g _tide_last_item_was_newline

    _tide_which_side_working_on=left for item in $tide_left_prompt_items
        _tide_item_$item
    end

    if not set -e _tide_last_item_was_newline
        set_color $_tide_previous_bg_color -b normal
        echo -ns $tide_left_prompt_suffix
    end
end

function _tide_right_prompt
    set -g _tide_last_item_was_newline

    _tide_which_side_working_on=right for item in $tide_right_prompt_items
        _tide_item_$item
    end

    if not set -e _tide_last_item_was_newline
        set_color $_tide_previous_bg_color -b normal
        echo -ns $tide_right_prompt_suffix
    end
end

function _tide_item_pwd
    _tide_print_item pwd @PWD@
end
