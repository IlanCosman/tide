function _tide_remove_unusable_items
    # Remove tool-specific items for tools the machine doesn't have installed
    for item in chruby git nvm php rust virtual_env
        set -l cliName $item
        switch $item
            case virtual_env
                set cliName python
            case rust
                set cliName rustc
        end

        if not type -q $cliName
            _tide_find_and_remove $item tide_left_prompt_items
            _tide_find_and_remove $item tide_right_prompt_items
        end
    end
end
