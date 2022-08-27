function _tide_item_rustc
    path is $_tide_parent_dirs/Cargo.toml &&
        _tide_print_item rustc $tide_rustc_icon' ' (rustc --version | string split ' ')[2]
end
