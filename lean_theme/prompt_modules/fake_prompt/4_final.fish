    # Prompt character
    if test $last_status -eq 0
        set_color $lean_color_green
    else
        set_color $fish_color_error
    end
    echo -n '❯ '
    set_color $fish_color_normal
end