# Created by lean configure
function fish_prompt --description 'Write out the prompt'
    set -g last_pipestatus $pipestatus
    set -g last_status $status

    echo

    set_color $lean_prompt_connection_color
    printf "%.s$lean_prompt_connection_icon" (seq $COLUMNS)
    set_color $fish_color_normal

    echo -ne '\r'(lean_pwd)(lean_git_prompt)' '

    set -l rightPrompt (lean_right_prompt)
    set -l rightPromptStartLocation (math $COLUMNS-(string length (lean_decolor $rightPrompt)))
    printf '\r\033['$rightPromptStartLocation'C'
    echo $rightPrompt

    # Prompt character
    if test $last_status -eq 0
        set_color $lean_color_green
    else
        set_color $fish_color_error
    end
    echo -n '❯ '
    set_color $fish_color_normal
end
