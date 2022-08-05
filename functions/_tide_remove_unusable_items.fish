function _tide_remove_unusable_items
    # Remove tool-specific items for tools the machine doesn't have installed
    set -l removed_items
    for item in aws chruby crystal docker git go java kubectl nix_shell node php rustc terraform toolbox virtual_env
        set -l cli_names $item
        switch $item
            case virtual_env
                set cli_names python python3
            case nix_shell
                set cli_names nix nix-shell
        end
        type --query $cli_names || set -a removed_items $item
    end

    set -U _tide_left_items (for item in $tide_left_prompt_items
        contains $item $removed_items || echo $item
    end)
    set -U _tide_right_items (for item in $tide_right_prompt_items
        contains $item $removed_items || echo $item
    end)
end
