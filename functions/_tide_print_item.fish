function _tide_print_item -a item
    itemColorName=tide_"$item"_color set itemColor $$itemColorName
    itemBgColorName=tide_"$item"_bg_color set itemBgColor $$itemBgColorName

    if test "$_tide_which_side_working_on" = left
        if test "$tide_last_item" = newline
            if test "$item" != character
                set_color $itemBgColor -b normal
                printf '%s' $tide_left_prompt_prefix
            end
        else if test "$itemBgColor" = "$tide_previous_bg_color"
            set_color $tide_left_prompt_item_separator_same_color_color
            printf '%s' $tide_left_prompt_item_separator_same_color
        else
            set_color $tide_previous_bg_color -b $itemBgColor
            printf '%s' $tide_left_prompt_item_separator_diff_color
        end
    else
        if test "$tide_last_item" = newline
            if test "$item" != character
                set_color $itemBgColor -b normal
                printf '%s' $tide_right_prompt_prefix
            end
        else if test "$itemBgColor" = "$tide_previous_bg_color"
            set_color $tide_right_prompt_item_separator_same_color_color
            printf '%s' $tide_right_prompt_item_separator_same_color
        else
            set_color $itemBgColor -b $tide_previous_bg_color
            printf '%s' $tide_right_prompt_item_separator_diff_color
        end
    end

    set_color $itemColor -b $itemBgColor

    test "$tide_prompt_pad_items" = true -a "$item" != character && set -l padItem ' '
    itemIconName=tide_"$item"_icon printf '%s' $padItem $$itemIconName' ' $argv[2..] $padItem

    set -g tide_previous_bg_color $itemBgColor
    set -g tide_last_item $item
end
