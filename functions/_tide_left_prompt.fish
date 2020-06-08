function _tide_left_prompt
    for item in _tide_item_{$tide_left_prompt_items}
        printf '%b' ($item)$_tide_color_normal
    end
end