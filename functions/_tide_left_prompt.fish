function _tide_left_prompt
    for item in _tide_item_{$tide_left_prompt_items}
        set -l itemOutput ($item)
        printf '%b' "$itemOutput"

        set_color normal
    end
end