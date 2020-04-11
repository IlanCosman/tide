function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    echo

    echo (lean_pwd)(lean_git_prompt)

    # Prompt character
    set_color $fish_color_normal
    if test $last_status -eq 0
        set_color $lean_green
    else
        set_color $fish_color_error
    end
    echo -n "❯ "
    set_color $fish_color_normal
end
