function _tide_item_prompt_char
    if test $_tide_last_status -eq 0
        set_color $tide_prompt_char_success_color
    else
        set_color $tide_prompt_char_failure_color
    end
    printf '%s ' "$tide_prompt_char_icon"
end