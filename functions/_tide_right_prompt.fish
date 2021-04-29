function _tide_right_prompt
    set -g tide_last_item newline
    set -g _tide_which_side_working_on right

    for item in $tide_right_prompt_items
        _tide_item_$item
    end

    if test "$tide_last_item" != newline
        set_color $tide_previous_bg_color -b normal
        printf '%s' $tide_right_prompt_suffix
    end

    set_color normal # Make sure there is something printed on the last line
end
