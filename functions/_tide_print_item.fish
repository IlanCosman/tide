function _tide_print_item -a item
    item_bg_color_name=tide_"$item"_bg_color set item_bg_color $$item_bg_color_name

    if test "$_tide_which_side_working_on" = left
        if test "$_tide_last_item" = newline
            if test "$item" != character
                set_color $item_bg_color -b normal
                printf '%s' $tide_left_prompt_prefix
            end
        else if test "$item_bg_color" = "$_tide_previous_bg_color"
            set_color $tide_prompt_color_separator_same_color
            printf '%s' $tide_left_prompt_separator_same_color
        else
            set_color $_tide_previous_bg_color -b $item_bg_color
            printf '%s' $tide_left_prompt_separator_diff_color
        end
    else if test "$_tide_last_item" = newline
        set_color $item_bg_color -b normal
        printf '%s' $tide_right_prompt_prefix
    else if test "$item_bg_color" = "$_tide_previous_bg_color"
        set_color $tide_prompt_color_separator_same_color
        printf '%s' $tide_right_prompt_separator_same_color
    else
        set_color $item_bg_color -b $_tide_previous_bg_color
        printf '%s' $tide_right_prompt_separator_diff_color
    end

    item_color_name=tide_"$item"_color set_color $$item_color_name -b $item_bg_color

    if test "$tide_prompt_pad_items" = true -a "$item" != character
        printf '%s' ' ' $argv[2..] ' '
    else
        printf '%s' $argv[2..]
    end

    set -g _tide_previous_bg_color $item_bg_color
    set -g _tide_last_item $item
end
