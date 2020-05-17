function lean_left_prompt
    for item in lean_{$lean_left_prompt_items}
        set -l itemOutput (_$item)
        printf "$itemOutput"

        set_color normal
    end
end