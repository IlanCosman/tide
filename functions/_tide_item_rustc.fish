function _tide_item_rustc
    if path is $_tide_parent_dirs/Cargo.toml
        rustup show active-toolchain -v | string match -qr "rustc (?<v>\d+\.\d+\.\d+)"
        _tide_print_item rustc $tide_rustc_icon' ' $v
    end
end
