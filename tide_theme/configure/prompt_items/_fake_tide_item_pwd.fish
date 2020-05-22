function _fake_tide_item_pwd
    set_color -o $_tide_color_light_blue
    printf '%s' '~'
    set_color normal
    
    set_color $_tide_color_dark_blue
    printf '%s' '/'
    set_color normal

    set_color -o $_tide_color_light_blue
    printf '%s' 'src'

    printf '%s' ' '
end