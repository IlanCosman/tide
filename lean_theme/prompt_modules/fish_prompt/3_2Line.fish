    set_color $lean_prompt_connection_color
    printf "%.s$lean_prompt_connection" (seq (math $COLUMNS-1))
    set_color $fish_color_normal

    lean_load_right_prompt_modules
    set -l leanRightPromptStartLocation (math $COLUMNS-(string length (_lean_right_prompt_nocolor)))
    printf "\r\033["$leanRightPromptStartLocation"C"
    echo -n (lean_right_prompt)
    
    echo -e "\r"(lean_pwd)(lean_git_prompt)" "