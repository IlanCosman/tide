function _tide_remove_unusable_items
    # Remove tool-specific items for tools the machine doesn't have installed
    set -l removed_items
    for item in aws chruby crystal distrobox docker git go java kubectl nix_shell node php pulumi rustc terraform toolbox virtual_env
        set -l cli_names $item
        switch $item
            case distrobox                           # there is no '/usr/bin/distrobox' inside the container. 'distrobox-export' and 'distrobox-host-exec' are found. 
                set cli_names distrobox-export       # It would be more accurate to check the existence of these two files. See: https://github.com/IlanCosman/tide/pull/351
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
