function _tide_print_item -a item
    itemBgColorName=tide_"$item"_bg_color set itemBgColor $$itemBgColorName

    if test "$_tide_which_side_working_on" = left
        if test "$_tide_last_item" = newline
            if test "$item" != character
                set_color $itemBgColor -b normal
                printf '%s' $tide_left_prompt_prefix
            end
        else if test "$itemBgColor" = "$_tide_previous_bg_color"
            set_color $tide_left_prompt_item_separator_same_color_color
            printf '%s' $tide_left_prompt_item_separator_same_color
        else
            set_color $_tide_previous_bg_color -b $itemBgColor
            printf '%s' $tide_left_prompt_item_separator_diff_color
        end
    else if test "$_tide_last_item" = newline
        set_color $itemBgColor -b normal
        printf '%s' $tide_right_prompt_prefix
    else if test "$itemBgColor" = "$_tide_previous_bg_color"
        set_color $tide_right_prompt_item_separator_same_color_color
        printf '%s' $tide_right_prompt_item_separator_same_color
    else
        set_color $itemBgColor -b $_tide_previous_bg_color
        printf '%s' $tide_right_prompt_item_separator_diff_color
    end

    itemColorName=tide_"$item"_color set_color $$itemColorName -b $itemBgColor

    if test "$tide_prompt_pad_items" = true -a "$item" != character
        printf '%s' ' ' $argv[2..] ' '
    else
        printf '%s' $argv[2..]
    end

    set -g _tide_previous_bg_color $itemBgColor
    set -g _tide_last_item $item
end
