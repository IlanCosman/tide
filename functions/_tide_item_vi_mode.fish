function _tide_item_vi_mode
    test "$fish_key_bindings" != fish_default_key_bindings && switch $fish_bind_mode
        case default
            set -g tide_vi_mode_bg_color $tide_vi_mode_default_bg_color
            set_color $tide_vi_mode_default_color
            printf '%s' $tide_vi_mode_default_icon
        case insert
            set -g tide_vi_mode_bg_color $tide_vi_mode_insert_bg_color
            set_color $tide_vi_mode_insert_color
            printf '%s' $tide_vi_mode_insert_icon
        case replace replace_one
            set -g tide_vi_mode_bg_color $tide_vi_mode_replace_bg_color
            set_color $tide_vi_mode_replace_color
            printf '%s' $tide_vi_mode_replace_icon
        case visual
            set -g tide_vi_mode_bg_color $tide_vi_mode_visual_bg_color
            set_color $tide_vi_mode_visual_color
            printf '%s' $tide_vi_mode_visual_icon
    end
end
