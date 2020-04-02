function lean_git_prompt
    set gitPrompt (fish_git_prompt)

    set gitPrompt (string replace "(" "" $gitPrompt)
    set gitPrompt (string replace ")" "" $gitPrompt)

    echo $gitPrompt
end