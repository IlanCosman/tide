function _tide_item_newline
    set_color $_tide_previous_bg_color -b normal
    var=tide_"$_tide_side"_prompt_suffix echo $$var
    set -g _tide_last_item_was_newline
end
