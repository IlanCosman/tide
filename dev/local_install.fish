function local_install -a localRepo
    if source "$localRepo/install.fish"
        cp -r "$localRepo/conf.d" $__fish_config_dir
        cp -r "$localRepo/functions" $__fish_config_dir
        cp -r "$localRepo/tide_theme" $__fish_config_dir
        cp -r "$localRepo/tests" $__fish_config_dir
        cp -r "$localRepo/dev/." "$__fish_config_dir/functions"

        _set_tide_defaults
        _source_tide_functions

        # Install fisher and fishtape for testing
        curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
        fisher add jorgebucaran/fishtape
    end
end