function _tide_item_character
    test $_tide_status = 0 && set_color $tide_character_color || set_color $tide_character_color_failure

    set -q add_prefix || echo -ns ' '

    if test "$fish_key_bindings" = fish_default_key_bindings
        test $_tide_status = 0 && echo -ns $tide_character_icon || echo -ns $tide_character_icon_failure
    else
        switch $fish_bind_mode
            case insert
                test $_tide_status = 0 && echo -ns $tide_character_icon || echo -ns $tide_character_icon_failure
            case default
                echo -ns $tide_character_vi_icon_default
            case replace replace_one
                echo -ns $tide_character_vi_icon_replace
            case visual
                echo -ns $tide_character_vi_icon_visual
        end
    end
end
