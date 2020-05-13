function local_install -a localRepo
    source "$localRepo/install.fish"; and _set_lean_defaults

    cp -r "$localRepo/functions" $__fish_config_dir
    cp -r "$localRepo/lean_theme" $__fish_config_dir
    cp -r "$localRepo/tests" $__fish_config_dir
    cp -r "$localRepo/dev/." "$__fish_config_dir/functions"

    # Install fisher and fishtape for testing
    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
    fisher add jorgebucaran/fishtape
end