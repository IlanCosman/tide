# RUN: %fish %s

function _nix_shell
    _tide_decolor (_tide_item_nix_shell)
end

set -lx tide_nix_shell_icon 
set -e IN_NIX_SHELL

_nix_shell # CHECK:

set -lx IN_NIX_SHELL pure
_nix_shell # CHECK:  pure

set -lx IN_NIX_SHELL impure
_nix_shell # CHECK:  impure

set -e IN_NIX_SHELL
