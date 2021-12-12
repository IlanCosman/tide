function _tide_item_character
    test $_tide_status = 0 && set_color $tide_character_color || set_color $tide_character_color_failure

    set -q add_prefix || echo -ns ' '

    test "$fish_key_bindings" = fish_default_key_bindings && echo -ns $tide_character_icon ||
        switch $fish_bind_mode
            case insert
                echo -ns $tide_character_icon
            case default
                echo -ns $tide_character_vi_icon_default
            case replace replace_one
                echo -ns $tide_character_vi_icon_replace
            case visual
                echo -ns $tide_character_vi_icon_visual
        end
end
