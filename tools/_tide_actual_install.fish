function _tide_actual_install
    argparse 'l/local' 'u/unattended' -- $argv

    set -l location $argv[1]
    if test -z "$location"
        set location 'main'
    end

    set -gx TERM xterm # Necessary for testing purposes, ensures color codes are printed

    printf '%s\n' 'Installing tide theme...'

    # -----------------Download Files-----------------
    set -lx tempDir (mktemp -d)

    # Copy/clone repository into $tempDir
    if set -q _flag_local
        cp -r $location/* $tempDir
    else
        git clone --quiet --depth 1 --branch $location https://github.com/IlanCosman/tide.git $tempDir
    end

    for dir in completions conf.d functions tide_theme
        cp -r "$tempDir/$dir" $__fish_config_dir
    end

    # --------------------Set Defaults--------------------
    _set_immutables

    set -U _tide_var_list

    source "$_tide_dir/configure/choices/all/style.fish"
    _load_config 'lean'

    source "$_tide_dir/configure/choices/all/finish.fish"
    _tide_finish

    # -----------------------Finish-----------------------
    for file in $_tide_file_list
        source "$__fish_config_dir/$file"
    end
    source "$__fish_config_dir/functions/fish_prompt.fish"

    set_color $_tide_color_green
    printf '%s\n' 'Tide theme installed!'
    set_color normal
    printf '%s\n'

    if not set -q _flag_unattended
        if _user_confirm_defaultYes 'Configure tide prompt?'
            tide configure
        else
            printf '%s\n'
            printf '%s\n' 'Run tide configure to customize your prompt.'
        end
    end

    rm -rf $tempDir
end

function _set_immutables
    set -U _tide_var_immutable_list

    _set_immutable _tide_color_dark_blue 0087AF
    _set_immutable _tide_color_dark_green 5FAF00
    _set_immutable _tide_color_gold D7AF00
    _set_immutable _tide_color_green 5FD700
    _set_immutable _tide_color_light_blue 00AFFF
    _set_immutable _tide_color_normal (set_color normal)

    _set_immutable _tide_dir "$__fish_config_dir/tide_theme"

    _set_immutable _tide_file_list (string replace "$tempDir/" '' $tempDir/{completions/*, conf.d/*, functions/*})

    _set_immutable _tide_version 2.4.0

    _set_immutable NVM_DIR $HOME/.nvm
    _set_immutable VIRTUAL_ENV_DISABLE_PROMPT true
end

function _set_immutable -a var_name
    set -U $var_name $argv[2..-1]
    set -a _tide_var_immutable_list $var_name
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
