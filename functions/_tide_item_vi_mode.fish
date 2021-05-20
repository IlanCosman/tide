function _tide_item_vi_mode
    test "$fish_key_bindings" != fish_default_key_bindings && switch $fish_bind_mode
        case default
            set -g tide_vi_mode_bg_color $tide_vi_mode_bg_color_default
            set_color $tide_vi_mode_color_default
            printf '%s' $tide_vi_mode_icon_default
        case insert
            set -g tide_vi_mode_bg_color $tide_vi_mode_bg_color_insert
            set_color $tide_vi_mode_color_insert
            printf '%s' $tide_vi_mode_icon_insert
        case replace replace_one
            set -g tide_vi_mode_bg_color $tide_vi_mode_bg_color_replace
            set_color $tide_vi_mode_color_replace
            printf '%s' $tide_vi_mode_icon_replace
        case visual
            set -g tide_vi_mode_bg_color $tide_vi_mode_bg_color_visual
            set_color $tide_vi_mode_color_visual
            printf '%s' $tide_vi_mode_icon_visual
    end
end
