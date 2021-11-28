function _tide_print_item -a item
    var=tide_"$item"_bg_color set -f item_bg_color $$var

    if set -e add_prefix
        set_color $item_bg_color -b normal
        var=tide_"$_tide_side"_prompt_prefix echo -ns $$var
    else if test "$item_bg_color" = "$prev_bg_color"
        var=tide_"$_tide_side"_prompt_separator_same_color echo -ns $_tide_color_separator_same_color$$var
    else if test $_tide_side = left
        set_color $prev_bg_color -b $item_bg_color
        echo -ns $tide_left_prompt_separator_diff_color
    else
        set_color $item_bg_color -b $prev_bg_color
        echo -ns $tide_right_prompt_separator_diff_color
    end

    var=tide_"$item"_color set_color $$var -b $item_bg_color

    echo -ns $_tide_pad $argv[2..] $_tide_pad

    set -g prev_bg_color $item_bg_color
end
