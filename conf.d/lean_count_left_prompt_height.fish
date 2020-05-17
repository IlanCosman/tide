function lean_count_left_prompt_height --on-variable lean_left_prompt_items
    set -U lean_left_prompt_height 1

    for item in $lean_left_prompt_items
        if test $item = 'newline'
            set -U lean_left_prompt_height (math $lean_left_prompt_height+1)
        end
    end
end