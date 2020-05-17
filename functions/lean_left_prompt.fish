function lean_left_prompt
    set -U lean_left_prompt_height 1

    for item in lean_{$lean_left_prompt_items}
        set -l itemOutput (_$item)

        if test -n "$itemOutput"
            printf $itemOutput
        end
        if test $item = 'lean_newline'
            set -U lean_left_prompt_height (math $lean_left_prompt_height+1)
        end

        set_color normal
    end
end