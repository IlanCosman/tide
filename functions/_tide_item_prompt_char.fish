function _tide_item_prompt_char
    if test $_tide_last_status = 0
        set_color $tide_prompt_char_success_color
    else
        set_color $tide_prompt_char_failure_color
    end

    if test "$fish_key_bindings" = fish_default_key_bindings
        printf '%s' $tide_prompt_char_icon
    else
        switch $fish_bind_mode
            case default
                printf '%s' $tide_prompt_char_vi_default_icon
            case insert
                printf '%s' $tide_prompt_char_vi_insert_icon
            case replace replace_one
                printf '%s' $tide_prompt_char_vi_replace_icon
            case visual
                printf '%s' $tide_prompt_char_vi_visual_icon
        end
    end
end
