function _fake_tide_pwd
    set_color -o $tide_color_light_blue
    printf '%s' '~'
    set_color normal
    
    set_color $tide_color_dark_blue
    printf '%s' '/'
    set_color normal

    set_color -o $tide_color_light_blue
    printf '%s' 'src'

    printf '%s' ' '
end