function _fake_tide_count_left_prompt_height -v fake_tide_left_prompt_items
    set -l numberOfNewlines (count (string match --all 'newline' $fake_tide_left_prompt_items))
    set -g _fake_tide_left_prompt_height (math 1+$numberOfNewlines)
end