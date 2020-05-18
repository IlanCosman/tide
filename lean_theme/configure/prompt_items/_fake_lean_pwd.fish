function _fake_lean_pwd
    set_color -o $lean_color_light_blue
    printf '%s' '~'
    set_color normal
    
    set_color $lean_color_dark_blue
    printf '%s' '/'
    set_color normal

    set_color -o $lean_color_light_blue
    printf '%s' 'src'

    printf '%s' ' '
end