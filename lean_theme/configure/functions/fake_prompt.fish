function fake_prompt
    if test "$fake_lean_newline" = 'true'
        printf '\n'
    end

    set_color $fake_lean_prompt_connection_color
    printf "%.s$fake_lean_prompt_connection_icon" (seq $fake_columns)
    set_color $fish_color_normal

    printf '\r'
    fake_lean_right_prompt

    printf '\r'
    fake_lean_left_prompt
end