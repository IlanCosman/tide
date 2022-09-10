function _tide_sub_remove
    for item in $argv
        if _tide_find_and_remove $item tide_left_prompt_items ||
                _tide_find_and_remove $item tide_right_prompt_items
            echo "Removed $item"
        else
            echo "$item not found"
        end
    end
    _tide_cache_variables
    return 0
end
