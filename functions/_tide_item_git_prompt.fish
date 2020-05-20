function _tide_item_git_prompt
    if set -l gitPrompt (fish_git_prompt)

        set -l gitPrompt (string replace '(' '' $gitPrompt)
        set -l gitPrompt (string replace ')' '' $gitPrompt)

        printf '%s ' (string trim $gitPrompt)
    end
end