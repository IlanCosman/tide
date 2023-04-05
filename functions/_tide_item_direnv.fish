function _tide_item_direnv
    set -q DIRENV_DIR || return
    direnv status | string match -q 'Found RC allowed false' \
        && set -lx tide_direnv_color $tide_direnv_color_denied \
        && set -lx tide_direnv_bg_color $tide_direnv_bg_color_denied
    _tide_print_item direnv $tide_direnv_icon
end
