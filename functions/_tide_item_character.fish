function _tide_item_character
    if test $_tide_last_status = 0
        set -g tide_character_color $tide_character_success_color
    else
        set -g tide_character_color $tide_character_failure_color
    end

    if test "$fish_key_bindings" = fish_default_key_bindings
        _tide_print_item character $tide_character_icon
    else
        switch $fish_bind_mode
            case default
                _tide_print_item character $tide_character_vi_default_icon
            case insert
                _tide_print_item character $tide_character_vi_insert_icon
            case replace replace_one
                _tide_print_item character $tide_character_vi_replace_icon
            case visual
                _tide_print_item character $tide_character_vi_visual_icon
        end
    end
end
