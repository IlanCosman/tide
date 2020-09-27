function _tide_item_rust
    if command --quiet rustc && test -e Cargo.toml -o (count *.rs) -gt 0
        set_color $tide_rust_color

        if test "$tide_rust_verbose_version" = false
            # Cut off -suffixes. "v1.30.0-beta" vs "v1.30.0"
            printf '%s' $tide_rust_icon' ' (rustc --version | string split ' ' | string split '-')[2]
        else
            printf '%s' $tide_rust_icon' ' (rustc --version | string split ' ')[2]
        end
    end
end