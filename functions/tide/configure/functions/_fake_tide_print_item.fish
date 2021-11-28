function _fake_tide_print_item -a item
    var=fake_tide_"$item"_bg_color set -f item_bg_color $$var

    if set -e add_prefix
        set_color $item_bg_color -b normal
        var=fake_tide_"$_fake_tide_side"_prompt_prefix echo -ns $$var
    else if test "$item_bg_color" = "$prev_bg_color"
        var=fake_tide_"$_fake_tide_side"_prompt_separator_same_color echo -ns $_fake_tide_color_separator_same_color$$var
    else if test "$_fake_tide_side" = left
        set_color $prev_bg_color -b $item_bg_color
        echo -ns $fake_tide_left_prompt_separator_diff_color
    else
        set_color $item_bg_color -b $prev_bg_color
        echo -ns $fake_tide_right_prompt_separator_diff_color
    end

    var=fake_tide_"$item"_color set_color $$var -b $item_bg_color

    echo -ns $_fake_tide_pad $argv[2..] $_fake_tide_pad

    set -g prev_bg_color $item_bg_color
end
