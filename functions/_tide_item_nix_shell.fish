function _tide_item_nix_shell
    if set -q IN_NIX_SHELL
        _tide_print_item nix_shell $tide_nix_shell_icon' ' $IN_NIX_SHELL
    else
        for path_item in $PATH
            if string match -q '/nix/store/*' $path_item
                # if nix is ran with `nix shell` we cannot determine pure/impure
                _tide_print_item nix_shell $tide_nix_shell_icon' ' unknown
                return
            end
        end
    end
end
