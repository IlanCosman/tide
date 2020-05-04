function local_install -a localRepo
    source "$localRepo/install.fish"
    lean_install
    cp -r "$localRepo/functions" $__fish_config_dir
    cp -r "$localRepo/lean_theme" $__fish_config_dir
    cp -r "$localRepo/tests" $__fish_config_dir
    cp -r "$localRepo/dev/." "$__fish_config_dir/functions"
end