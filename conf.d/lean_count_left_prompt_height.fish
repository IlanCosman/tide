function lean_count_left_prompt_height --on-variable lean_left_prompt_items
    set -l numberOfNewlines (count (string match -a 'newline' $lean_left_prompt_items))
    set -U lean_left_prompt_height (math 1+$numberOfNewlines)
end