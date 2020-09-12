function _tide_count_left_prompt_height --on-variable tide_left_prompt_items
    set -l numberOfNewlines (string match --all 'newline' $tide_left_prompt_items | count)
    set -g _tide_left_prompt_height (math 1+$numberOfNewlines)
end