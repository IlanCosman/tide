function _fake_tide_item_pwd
    if set -q $fake_tide_pwd_anchors[1]
        set_color -o
    end

    set_color $fake_tide_pwd_color_dirs
    printf '%s' '~'
    set_color normal

    set_color $fake_tide_pwd_color_dirs
    printf '%s' '/'

    if set -q $fake_tide_pwd_anchors[1]
        set_color -o
    end

    set_color $fake_tide_pwd_color_dirs
    printf '%s ' 'src'
end