function _fake_tide_item_newline
    set_color $_fake_tide_previous_bg_color -b normal
    side_working_on_suffix_name=fake_tide_"$_fake_tide_which_side_working_on"_prompt_suffix printf '%s' $$side_working_on_suffix_name \n
    set -g _fake_tide_last_item newline
end
