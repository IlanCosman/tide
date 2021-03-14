function fish_right_prompt
    printf '%s' $$_tide_right_prompt_display_var
    # Right prompt is always the last thing on the line 
    # therefore reset colors for tab completion
    set_color normal
end
