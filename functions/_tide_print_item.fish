set -g tide_last_item newline

function _tide_print_item -a item
    itemColorName=tide_"$item"_color set itemColor $$colorName
    itemBgColorName=tide_"$item"_bg_color set itemBgColor $$itemBgColor

    if test "$tide_last_item" = newline
        if test "$item" != prompt_char
            set_color $itemBgColorName -b normal
            printf '%s' $tide_left_prompt_prefix
        end
    else if test "$itemBgColor" = "$tide_previous_bg_color"
        set_color $tide_left_prompt_item_separator_same_color_color
        printf '%s' $tide_left_prompt_item_separator_same_color
    else
        set_color $tide_previous_bg_color -b $itemBgColor
        printf '%s' $tide_left_prompt_item_separator_diff_color
    end

    set_color $itemColor -b $itemBgColor

    test "$tide_left_prompt_pad_items" = true -a "$item" != prompt_char && set -l padItem ' '
    itemIconName=tide_"$item"_icon printf '%s' $padItem $$itemIconName' ' $argv[2..] $padItem

    set -g tide_previous_bg_color $itemBgColor
    set -g tide_last_item $item
end
