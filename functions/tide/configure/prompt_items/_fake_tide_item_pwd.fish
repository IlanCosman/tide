function _fake_tide_item_pwd
    printf '%s' (set_color $fake_tide_pwd_color_dirs)$fake_tide_pwd_dir_icon' '

    if set -q fake_tide_pwd_anchors[1]
        set_color -o $fake_tide_pwd_color_anchors
        printf '%s' '~'
        set_color normal -b $fake_tide_pwd_bg_color

        set_color $fake_tide_pwd_color_dirs
        printf '%s' '/'
        set_color normal -b $fake_tide_pwd_bg_color

        set_color -o $fake_tide_pwd_color_anchors
        printf '%s' 'src'
        set_color normal -b $fake_tide_pwd_bg_color
    else
        set_color $fake_tide_pwd_color_dirs
        printf '%s' '~/src'
    end
end