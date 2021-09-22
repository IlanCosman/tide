function _tide_print_item -a item
    var=tide_"$item"_bg_color set -f item_bg_color $$var

    if set -e _tide_last_item_was_newline
        set_color $item_bg_color -b normal
        var=tide_"$_tide_side"_prompt_prefix echo -ns $$var
    else if test "$item_bg_color" = "$_tide_previous_bg_color"
        set_color $tide_prompt_color_separator_same_color
        var=tide_"$_tide_side"_prompt_separator_same_color echo -ns $$var
    else if test "$_tide_side" = left
        set_color $_tide_previous_bg_color -b $item_bg_color
        echo -ns $tide_left_prompt_separator_diff_color
    else
        set_color $item_bg_color -b $_tide_previous_bg_color
        echo -ns $tide_right_prompt_separator_diff_color
    end

    var=tide_"$item"_color set_color $$var -b $item_bg_color

    if test "$tide_prompt_pad_items" = true
        echo -ns ' ' $argv[2..] ' '
    else
        echo -ns $argv[2..]
    end

    set -g _tide_previous_bg_color $item_bg_color
end
