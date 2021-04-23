function _tide_item_prompt_char
    if test $_tide_last_status = 0
        set -g tide_prompt_char_color $tide_prompt_char_success_color
    else
        set -g tide_prompt_char_color $tide_prompt_char_failure_color
    end

    if test "$fish_key_bindings" = fish_default_key_bindings
        _tide_print_item prompt_char
    else
        switch $fish_bind_mode
            case default
                tide_prompt_char_icon=$tide_prompt_char_vi_default_icon _tide_print_item prompt_char
            case insert
                tide_prompt_char_icon=$tide_prompt_char_vi_insert_icon _tide_print_item prompt_char
            case replace replace_one
                tide_prompt_char_icon=$tide_prompt_char_vi_replace_icon _tide_print_item prompt_char
            case visual
                tide_prompt_char_icon=$tide_prompt_char_vi_visual_icon _tide_print_item prompt_char
        end
    end
end
