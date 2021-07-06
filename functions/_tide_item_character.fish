function _tide_item_character
    test $_tide_last_status = 0 || set -g tide_character_color $tide_character_color_failure

    if test "$fish_key_bindings" = fish_default_key_bindings
        _tide_print_item character $tide_character_icon
    else
        switch $fish_bind_mode
            case insert
                _tide_print_item character $tide_character_icon
            case default
                _tide_print_item character $tide_character_vi_icon_default
            case replace replace_one
                _tide_print_item character $tide_character_vi_icon_replace
            case visual
                _tide_print_item character $tide_character_vi_icon_visual
        end
    end
end
