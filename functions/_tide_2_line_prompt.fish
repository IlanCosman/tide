function _tide_2_line_prompt
    set -g add_prefix
    _tide_side=left set -f left (for item in $_tide_left_items
            _tide_item_$item
        end)

    set -g add_prefix
    _tide_side=right set -f right (for item in $_tide_right_items
            _tide_item_$item
        end)

    echo -ns "$right[2]"\n"$left[1]"\n"$right[1]"\n"$left[2]"
end

function _tide_item_pwd
    _tide_print_item pwd @PWD@
end

function _tide_item_newline
    set_color $prev_bg_color -b normal
    var=tide_"$_tide_side"_prompt_suffix echo $$var
    set -g add_prefix
end
