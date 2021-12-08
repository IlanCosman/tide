function _tide_1_line_prompt
    set -g add_prefix
    _tide_side=left set -f left (for item in $_tide_left_items
            _tide_item_$item
        end
        set_color $prev_bg_color -b normal
        echo -ns $tide_left_prompt_suffix)

    set -g add_prefix
    _tide_side=right set -f right (for item in $_tide_right_items
            _tide_item_$item
        end
        set_color $prev_bg_color -b normal
        echo -ns $tide_right_prompt_suffix)

    # 5 = @PWD@ length which will be replaced
    math $COLUMNS+5-(string length --visible "$left[1]$right[1]") -$tide_prompt_min_cols | read -lx dist_btwn_sides
    string replace @PWD@ (_tide_pwd) "$right[1]" "$left[1] "
end

function _tide_item_pwd
    _tide_print_item pwd @PWD@
end
