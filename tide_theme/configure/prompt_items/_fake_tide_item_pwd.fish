function _fake_tide_item_pwd
    set_color -o $fake_tide_pwd_color_end_dirs
    printf '%s' '~'
    set_color normal

    set_color $fake_tide_pwd_color_mid_dirs
    printf '%s' '/'
    set_color normal

    set_color -o $fake_tide_pwd_color_end_dirs
    printf '%s' 'src'

    printf '%s' ' '
end