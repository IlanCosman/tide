function _tide_prompt
    set -g prev_item_was_newline
    _tide_side=left set -f left (for item in $tide_left_prompt_items
            _tide_item_$item
        end
        if not set -e prev_item_was_newline
            set_color $prev_bg_color -b normal
            echo -ns $tide_left_prompt_suffix
        end)

    set -g prev_item_was_newline
    _tide_side=right set -f right (for item in $tide_right_prompt_items
            _tide_item_$item
        end
        if not set -e prev_item_was_newline
            set_color $prev_bg_color -b normal
            echo -ns $tide_right_prompt_suffix
        end)

    if set -q _tide_prompt_and_frame_color # If prompt is two lines
        if test "$tide_left_prompt_frame_enabled" = true
            set left[1] "$_tide_prompt_and_frame_color╭─$left[1]"
            set left[2] "$_tide_prompt_and_frame_color╰─$left[2]"
        end
        if test "$tide_right_prompt_frame_enabled" = true
            set right[1] "$right[1]$_tide_prompt_and_frame_color─╮"
            set right[2] "$right[2]$_tide_prompt_and_frame_color─╯"
        end

        # 5 = @PWD@ length which will be replaced
        math $COLUMNS+5-(string length --visible "$left[1]$right[1]") | read -lx dist_btwn_sides
        echo -ns "$right[2]"\n(string replace @PWD@ (_tide_pwd) "$left[1]")$_tide_prompt_and_frame_color

        string repeat --no-newline --max (math max 0, $dist_btwn_sides-$pwd_length) $tide_prompt_icon_connection
        echo -ns "$right[1]"\n"$left[2] "
    else
        math $COLUMNS+5-(string length --visible "$left[1]$right[1]") -$tide_prompt_min_cols | read -lx dist_btwn_sides
        string replace @PWD@ (_tide_pwd) "$right[1]" "$left[1] "
    end
end

function _tide_item_pwd
    _tide_print_item pwd @PWD@
end
