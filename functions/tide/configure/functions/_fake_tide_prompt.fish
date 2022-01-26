function _fake_tide_prompt
    set -g add_prefix
    _fake_tide_side=left set -f left (for item in $fake_tide_left_prompt_items
            _fake_tide_item_$item
        end
        if not set -e add_prefix
            set_color $prev_bg_color -b normal
            echo -ns $fake_tide_left_prompt_suffix
        end)

    set -g add_prefix
    _fake_tide_side=right set -f right (for item in $fake_tide_right_prompt_items
            _fake_tide_item_$item
        end
        if not set -e add_prefix
            set_color $prev_bg_color -b normal
            echo -ns $fake_tide_right_prompt_suffix
        end)

    if set -q _fake_tide_prompt_and_frame_color # If prompt is two lines
        test "$fake_tide_left_prompt_frame_enabled" = true &&
            set left[1] "$_fake_tide_prompt_and_frame_color╭─$left[1]" &&
            set left[2] "$_fake_tide_prompt_and_frame_color╰─$left[2]"
        test "$fake_tide_right_prompt_frame_enabled" = true &&
            set right[1] "$right[1]$_fake_tide_prompt_and_frame_color─╮" &&
            set right[2] "$right[2]$_fake_tide_prompt_and_frame_color─╯"

        # 5 = @PWD@ length which will be replaced
        math $fake_columns+5-(string length --visible "$left[1]$right[1]") | read -lx dist_btwn_sides
        echo -ns "$right[2]"\n(string replace @PWD@ (_fake_tide_pwd) "$left[1]")$_fake_tide_prompt_and_frame_color

        string repeat --no-newline --max (math max 0, $dist_btwn_sides-$_tide_pwd_len) $fake_tide_prompt_icon_connection
        echo -ns "$right[1]"\n"$left[2] "
    else
        math $fake_columns+5-(string length --visible "$left[1]$right[1]") -$fake_tide_prompt_min_cols | read -lx dist_btwn_sides
        string replace @PWD@ (_fake_tide_pwd) "$right[1]" "$left[1] "
    end
end

function _fake_tide_item_pwd
    _fake_tide_print_item pwd @PWD@
end
