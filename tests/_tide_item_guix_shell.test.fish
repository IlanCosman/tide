# RUN: %fish %s
_tide_parent_dirs

function _guix_shell
    _tide_decolor (_tide_item_guix)
end


_guix_shell # CHECK:

set -x GUIX_ENVIRONMENT "/gnu/store/test"

_guix_shell # CHECK: [GUIX ENV]
