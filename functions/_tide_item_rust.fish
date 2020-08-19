function _tide_item_rust
    if not type --quiet rustc || not test -e Cargo.toml || test (count *.rs) -gt 0
        return
    end

    set -l rustVersion (rustc --version | string split ' ')[2]

    if test "$tide_rust_verbose_version" = false
        set rustVersion (string split '-' $rustVersion)[1] # Cut off -suffixes from version. "v1.30.0-beta" vs "v1.30.0"
    end

    set_color $tide_rust_color
    printf '%s' {$tide_rust_icon}' ' $rustVersion
end