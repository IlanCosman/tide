function _tide_item_sudo
    # note that calling `sudo -n` resets the sudo timer; as such, this item is disabled by default.
    sudo -n true &>/dev/null && _tide_print_item sudo $tide_sudo_icon
end
