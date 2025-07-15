function _tide_item_rustc
    if path is $_tide_parent_dirs/Cargo.toml
        type -q rustc && set -f cmd 'rustc --version' ||
        begin type -q rustup && set -f cmd 'rustup show active-toolchain -v'; end &&
        eval "$cmd" | string match -qr "(?<v>\d+\.\d+\.\d+)" && 
            _tide_print_item rustc $tide_rustc_icon' ' $v
    end
end
