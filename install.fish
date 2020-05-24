function tide_install
    argparse 'l/local' 'd/dev' -- $argv

    set -l location $argv[1]
    if test -z "$location"
        set location 'master'
    end

    printf '%s\n' 'Installing tide theme...'

    # -----------------Download Files-----------------
    set -l tempDir '/tmp/tide_theme'

    # Copy/clone repository into $tempDir
    if test -e $tempDir
        rm -rf $tempDir
    end
    if set -q _flag_local
        cp -rf "$location" "$tempDir"
    else
        git clone -q --depth=1 -b $location https://github.com/IlanCosman/tide.git $tempDir
    end

    cp -r "$tempDir/completions" $__fish_config_dir
    cp -r "$tempDir/conf.d" $__fish_config_dir
    cp -r "$tempDir/functions" $__fish_config_dir
    cp -r "$tempDir/tide_theme" $__fish_config_dir

    if set -q _flag_dev
        cp -r "$tempDir/tests" $__fish_config_dir
        cp -r "$tempDir/dev/." "$__fish_config_dir/functions"

        # Install fisher and fishtape for testing
        curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
        fisher add jorgebucaran/fishtape
    end

    # --------------------Set Defaults--------------------
    set -U _tide_file_list
    for file in $tempDir/{completions/*, conf.d/*, functions/*}
        set -a _tide_file_list (string replace "$tempDir/" '' $file)
    end

    source "$__fish_config_dir/tide_theme/configure/functions/_set_tide_defaults.fish"
    _set_tide_defaults

    # -----------------------Finish-----------------------
    _source_tide_functions

    set_color $_tide_color_green
    printf '%s\n' 'Tide theme installed!'
    set_color normal
    printf '%s\n'

    if _user_confirm_defaultYes 'Configure tide prompt?'
        tide configure
    else
        printf '%s\n'
        printf '%s\n' 'Run tide configure to customize your prompt.'
    end

    rm -rf $tempDir
end

function _source_tide_functions
    for file in $_tide_file_list
        source "$__fish_config_dir/$file"
    end
    source "$__fish_config_dir/functions/fish_prompt.fish"
end

function _user_confirm_defaultYes -a question
    while true
        read -P "$question [Y/n] " input

        switch $input
            case y Y yes Yes
                return 0
            case n N no No
                return 1
            case ''
                return 0
        end
    end
end