function _tide_item_rustc
    test -e Cargo.toml && _tide_print_item rustc (rustc --version | string split ' ')[2]
end
