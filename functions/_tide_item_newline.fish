function _tide_item_newline
    set_color $prev_bg_color -b normal
    var=tide_"$_tide_side"_prompt_suffix echo $$var
    set -g prev_item_was_newline
end
