function _tide_item_newline
    set_color $_tide_previous_bg_color -b normal
    side_working_on_suffix_name=tide_"$_tide_side"_prompt_suffix echo $$side_working_on_suffix_name
    set -g _tide_last_item_was_newline
end
