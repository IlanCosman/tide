function lean_right_prompt
    echo -n ' '

    for item in lean_{$lean_right_prompt_items}
        set -l itemOutput (_$item)

        if test -n "$itemOutput"
            echo -n $itemOutput' '
        end

        set_color normal
    end
end