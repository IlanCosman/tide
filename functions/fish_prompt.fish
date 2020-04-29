# Created by lean_wizard
function fish_prompt --description 'Write out the prompt'
    set -g last_pipestatus $pipestatus
    set -g last_status $status

    echo

    set_color $lean_prompt_connection_color
    printf "%.s$lean_prompt_connection_icon" (seq $COLUMNS)
    set_color $fish_color_normal

    echo -ne '\r'(lean_pwd)(lean_git_prompt)' '

    lean_load_right_prompt_items
    set -l leanRightPromptStartLocation (math $COLUMNS-(string length (_lean_right_prompt_nocolor)))
    printf '\r\033['$leanRightPromptStartLocation'C'
    echo -e (lean_right_prompt)

    # Prompt character
    if test $last_status -eq 0
        set_color $lean_color_green
    else
        set_color $fish_color_error
    end
    echo -n '❯ '
    set_color $fish_color_normal
end

function _lean_right_prompt_nocolor
    echo -n ' '

    for item in lean_{$lean_right_prompt_items}
        if test -n "$$item"
            echo -n "$$item"
            echo -n ' '
        end
    end
end

