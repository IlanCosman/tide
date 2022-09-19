function _tide_item_distrobox
    test -e /run/.distroboxenv &&
        _tide_print_item distrobox $tide_distrobox_icon' ' (string match -rg 'name="(.*)"' </run/.containerenv)
end
