function _lean_prompt_char
    if test $last_status -eq 0
        set_color $lean_color_green
    else
        set_color $fish_color_error
    end
    printf '❯ '
end