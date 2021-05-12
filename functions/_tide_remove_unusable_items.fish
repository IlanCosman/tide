function _tide_remove_unusable_items
    # Remove tool-specific items for tools the machine doesn't have installed
    for item in chruby git nvm php rustc virtual_env
        set -l cli_name $item
        switch $item
            case virtual_env
                set cli_name python
        end

        if not type -q $cli_name
            _tide_find_and_remove $item tide_left_prompt_items
            _tide_find_and_remove $item tide_right_prompt_items
        end
    end
end
