function lean_left_prompt
    for item in lean_{$lean_left_prompt_items}
        set -l itemOutput (_$item)

        if test -n "$itemOutput"
            printf $itemOutput
        end

        set_color normal
    end
end