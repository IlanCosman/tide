function _fake_tide_left_prompt
    for item in _fake_tide_item_{$fake_tide_left_prompt_items}
        set -l itemOutput ($item)
        printf '%b' "$itemOutput"

        set_color normal
    end
end