function _tide_item_rust
    if test -e Cargo.toml
        set_color $tide_rust_color
        printf '%s' $tide_rust_icon' ' (rustc --version | string split ' ')[2]
    end
end
