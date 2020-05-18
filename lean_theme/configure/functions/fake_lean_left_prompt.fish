function fake_lean_left_prompt
    for item in fake_lean_{$fake_lean_left_prompt_items}
        set -l itemOutput (_$item)
        printf '%b' "$itemOutput"

        set_color normal
    end
end