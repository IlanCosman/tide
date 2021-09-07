function _tide_item_character
    if test $_tide_last_status = 0
        set_color $tide_character_color
    else
        set_color $tide_character_color_failure
    end

    if test "$fish_key_bindings" = fish_default_key_bindings
        printf %s $tide_character_icon
    else
        switch $fish_bind_mode
            case insert
                printf %s $tide_character_icon
            case default
                printf %s $tide_character_vi_icon_default
            case replace replace_one
                printf %s $tide_character_vi_icon_replace
            case visual
                printf %s $tide_character_vi_icon_visual
        end
    end
end
