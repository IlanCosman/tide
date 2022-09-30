function _tide_item_distrobox
    command -q distrobox-enter || # distrobox-enter is not present in the container
        _tide_print_item distrobox $tide_distrobox_icon' ' (string match -rg 'name="(.*)"' </run/.containerenv)
end
