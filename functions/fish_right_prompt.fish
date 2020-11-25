function fish_right_prompt
    set -l displayVarName _tide_right_prompt_display_$fish_pid
    printf '%s' $$displayVarName
    # Right prompt is always the last thing on the line 
    # therefore reset colors for tab completion
    set_color normal
end
