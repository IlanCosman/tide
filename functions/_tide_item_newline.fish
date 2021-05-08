function _tide_item_newline
    set_color $_tide_previous_bg_color -b normal
    sideWorkingOnSuffixName=tide_"$_tide_which_side_working_on"_prompt_suffix printf '%s' $$sideWorkingOnSuffixName \n
    set -g _tide_last_item newline
end
