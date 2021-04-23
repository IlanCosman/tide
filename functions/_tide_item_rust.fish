function _tide_item_rust
    test -e Cargo.toml && _tide_print_item rust (rustc --version | string split ' ')[2]
end
