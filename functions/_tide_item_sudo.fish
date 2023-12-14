function _tide_item_sudo
    sudo -n true &>/dev/null && _tide_print_item sudo $tide_sudo_icon
end
