    set_color $lean_prompt_connection_color
    printf "%.s$lean_prompt_connection_icon" (seq $COLUMNS)
    set_color $fish_color_normal

    echo -ne '\r'(lean_pwd)(lean_git_prompt)' '
    
    set -l rightPrompt (lean_right_prompt)
    set -l rightPromptStartLocation (math $COLUMNS-(string length (lean_decolor $rightPrompt)))
    printf '\r\033['$rightPromptStartLocation'C'
    echo $rightPrompt