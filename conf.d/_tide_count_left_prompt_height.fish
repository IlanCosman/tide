function _tide_count_left_prompt_height --on-variable tide_left_prompt_items
    set -l numberOfNewlines (count (string match -a 'newline' $tide_left_prompt_items))
    set -U _tide_left_prompt_height (math 1+$numberOfNewlines)
end