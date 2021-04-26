function _tide_left_prompt
    set -g tide_last_item newline
    set -g _tide_which_side_working_on left

    for item in $tide_left_prompt_items
        switch $item
            case newline
                set_color $tide_previous_bg_color -b normal
                printf '%s' $tide_left_prompt_suffix\n
                set -g tide_last_item newline
            case '*'
                _tide_item_$item
        end
    end

    if test "$tide_last_item" != newline -a "$tide_last_item" != character
        set_color $tide_previous_bg_color -b normal
        printf '%s' $tide_left_prompt_suffix
    end

    set_color normal # Make sure there is something printed on the last line
end
