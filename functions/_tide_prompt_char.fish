function _tide_prompt_char
    if test $last_status -eq 0
        set_color $tide_color_green
    else
        set_color $fish_color_error
    end
    printf '%s ' '❯'
end