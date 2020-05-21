function tide_dev_install
    argparse 'b/branch' 'l/local' -- $argv

    if set -q _flag_branch
        curl -s "https://raw.githubusercontent.com/IlanCosman/tide/$argv/install.fish" | source; and tide_install $argv
        return $status
    end

    if set -q _flag_local
        _local_install $argv
        return $status
    end

    printf '%s' 'Please indicate local/branch'
    return 1
end

function _local_install -a localRepo
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