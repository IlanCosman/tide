function fake_prompt
    if test "$fake_tide_newline" = 'true'
        printf '\n'
    end

    set_color $fake_tide_prompt_connection_color
    printf "%.s$fake_tide_prompt_connection_icon" (seq $fake_columns)
    set_color $fish_color_normal

    printf '\r'
    fake_tide_right_prompt

    printf '\r'
    fake_tide_left_prompt
end