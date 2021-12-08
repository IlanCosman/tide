function _tide_2_line_prompt
    set -g add_prefix
    _tide_side=left set -f left (for item in $_tide_left_items
            _tide_item_$item
        end)

    set -g add_prefix
    _tide_side=right set -f right (for item in $_tide_right_items
            _tide_item_$item
        end)

    test "$tide_left_prompt_frame_enabled" = true &&
        set left[1] "$_tide_prompt_and_frame_color╭─$left[1]" &&
        set left[2] "$_tide_prompt_and_frame_color╰─$left[2]"
    test "$tide_right_prompt_frame_enabled" = true &&
        set right[1] "$right[1]$_tide_prompt_and_frame_color─╮" &&
        set right[2] "$right[2]$_tide_prompt_and_frame_color─╯"

    # 5 = @PWD@ length which will be replaced
    math $COLUMNS+5-(string length --visible "$left[1]$right[1]") | read -lx dist_btwn_sides
    echo -ns "$right[2]"\n(string replace @PWD@ (_tide_pwd) "$left[1]")$_tide_prompt_and_frame_color

    string repeat --no-newline --max (math max 0, $dist_btwn_sides-$pwd_length) $tide_prompt_icon_connection
    echo -ns "$right[1]"\n"$left[2] "
end

function _tide_item_pwd
    _tide_print_item pwd @PWD@
end

function _tide_item_newline
    set_color $prev_bg_color -b normal
    var=tide_"$_tide_side"_prompt_suffix echo $$var
    set -g add_prefix
end
