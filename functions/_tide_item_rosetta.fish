function _tide_item_rosetta
    if test (sysctl -ne sysctl.proc_translated) = 1
        set machine (uname -m)
        _tide_print_item rosetta $tide_rosetta_icon' ' $machine
    end
end
