    set_color $lean_prompt_connection_color
    printf "%.s$lean_prompt_connection_icon" (seq $COLUMNS)
    set_color $fish_color_normal

    echo -ne '\r'(lean_pwd)(lean_git_prompt)' '
    
    lean_load_right_prompt_items
    set -l leanRightPromptStartLocation (math $COLUMNS-(string length (_lean_right_prompt_nocolor)))
    printf '\r\033['$leanRightPromptStartLocation'C'
    echo -e (lean_right_prompt)