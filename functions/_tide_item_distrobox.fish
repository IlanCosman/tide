function _tide_item_distrobox
    test -e /etc/profile.d/distrobox_profile.sh && test -e /run/.containerenv &&                          # distrobox-enter is not present in the container
        _tide_print_item distrobox $tide_distrobox_icon' ' (string match -rg 'name="(.*)"' </run/.containerenv)
end
