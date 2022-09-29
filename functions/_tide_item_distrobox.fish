function _tide_item_distrobox
    if not command -v distrobox-enter >/dev/null
        if command -v distrobox-export >/dev/null
            _tide_print_item distrobox $tide_distrobox_icon' ' (string match -rg 'name="(.*)"' </run/.containerenv)
		end
	end
end
