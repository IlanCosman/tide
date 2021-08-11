function _tide_remove_unusable_items
    # Remove tool-specific items for tools the machine doesn't have installed
    for item in chruby git go kubectl node php rustc virtual_env
        set -l cli_names $item
        switch $item
            case virtual_env
                set cli_names python python3
        end

        if not type --query $cli_names
            _tide_find_and_remove $item tide_left_prompt_items
            _tide_find_and_remove $item tide_right_prompt_items
        end
    end
end
