function _tide_item_newline
    set_color $_tide_previous_bg_color -b normal
    side_working_on_suffix_name=tide_"$_tide_which_side_working_on"_prompt_suffix printf '%s' $$side_working_on_suffix_name \n
    set -g _tide_last_item newline
end
