function _tide_print_item -a item
    v=tide_"$item"_bg_color set -f item_bg_color $$v

    if set -e add_prefix
        set_color $item_bg_color -b normal
        v=tide_"$_tide_side"_prompt_prefix echo -ns $$v
    else if test "$item_bg_color" = "$prev_bg_color"
        v=tide_"$_tide_side"_prompt_separator_same_color echo -ns $_tide_color_separator_same_color$$v
    else if test $_tide_side = left
        set_color $prev_bg_color -b $item_bg_color
        echo -ns $tide_left_prompt_separator_diff_color
    else
        set_color $item_bg_color -b $prev_bg_color
        echo -ns $tide_right_prompt_separator_diff_color
    end

    v=tide_"$item"_color set_color $$v -b $item_bg_color

    echo -ns $_tide_pad $argv[2..] $_tide_pad

    set -g prev_bg_color $item_bg_color
end
