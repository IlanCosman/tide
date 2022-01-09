function _tide_1_line_prompt
    set -g add_prefix
    _tide_side=left for item in $_tide_left_items
        _tide_item_$item
    end
    set_color $prev_bg_color -b normal
    echo $tide_left_prompt_suffix

    set -g add_prefix
    _tide_side=right for item in $_tide_right_items
        _tide_item_$item
    end
    set_color $prev_bg_color -b normal
    echo $tide_right_prompt_suffix
end

function _tide_item_pwd
    _tide_print_item pwd @PWD@
end
