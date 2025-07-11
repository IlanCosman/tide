function _tide_item_sudo
    if sudo -n true 2>/dev/null
        _tide_print_item sudo $tide_sudo_icon
    end
end
