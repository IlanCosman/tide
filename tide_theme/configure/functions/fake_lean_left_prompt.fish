function fake_tide_left_prompt
    for item in fake_tide_{$fake_tide_left_prompt_items}
        set -l itemOutput (_$item)
        printf '%b' "$itemOutput"

        set_color normal
    end
end