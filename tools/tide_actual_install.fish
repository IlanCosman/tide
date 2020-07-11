function tide_actual_install
    argparse 'l/local' 'd/dev' 'u/unattended' -- $argv

    set -l location $argv[1]
    if test -z "$location"
        set location 'master'
    end

    set -gx TERM xterm # Necessary for testing purposes, ensures color codes are printed

    printf '%s\n' 'Installing tide theme...'

    # -----------------Download Files-----------------
    set -g tempDir '/tmp/tide_theme'

    # Copy/clone repository into $tempDir
    if test -e $tempDir
        rm -rf $tempDir
    end
    if set -q _flag_local
        cp -rf "$location" "$tempDir"
    else
        git clone -q --depth 1 -b $location https://github.com/IlanCosman/tide.git $tempDir
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
    _set_immutables

    cat "$_tide_dir/configure/fish_prompt.fish" >"$__fish_config_dir/functions/fish_prompt.fish"

    set -U _tide_var_list

    source "$_tide_dir/configure/choices/all/style.fish"
    _load_config 'lean'

    for fakeVar in $fake_tide_var_list
        set -l normalVar (string replace 'fake_' '' $fakeVar)
        set -U $normalVar $$fakeVar
        set -a _tide_var_list $normalVar
        set -e $fakeVar
    end

    source "$__fish_config_dir/conf.d/_tide_Ω_run_on_startup.fish"

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
    set -e tempDir
end

function _set_immutables
    set -U _tide_var_immutable_list

    _set_immutable _tide_file_list
    for file in $tempDir/{completions/*, conf.d/*, functions/*}
        set -a _tide_file_list (string replace "$tempDir/" '' "$file")
    end

    _set_immutable _tide_version 2.0.0
    _set_immutable _tide_dir "$__fish_config_dir/tide_theme"
    # --------------Colors--------------
    _set_immutable _tide_color_green 5FD700
    _set_immutable _tide_color_light_blue 00AFFF
    _set_immutable _tide_color_dark_blue 0087AF
    _set_immutable _tide_color_normal (set_color normal)

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