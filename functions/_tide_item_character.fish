function _tide_item_character
    if test $_tide_last_status = 0
        set -g tide_character_color $tide_character_success_color
    else
        set -g tide_character_color $tide_character_failure_color
    end

    if test "$fish_key_bindings" = fish_default_key_bindings
        _tide_print_item character
    else
        switch $fish_bind_mode
            case default
                tide_character_icon=$tide_character_vi_default_icon _tide_print_item character
            case insert
                tide_character_icon=$tide_character_vi_insert_icon _tide_print_item character
            case replace replace_one
                tide_character_icon=$tide_character_vi_replace_icon _tide_print_item character
            case visual
                tide_character_icon=$tide_character_vi_visual_icon _tide_print_item character
        end
    end
end
