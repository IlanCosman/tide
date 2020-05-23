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
    # Add contents of conf.d and functions to a list for uninstallation
    set -U _tide_file_list

    for file in $tempDir/{conf.d/*, functions/*}
        if test "$file" != "$tempDir/functions/fish_prompt.fish"
            set -a _tide_file_list (string replace "$tempDir/" '' $file)
        end
    end

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

function _set_tide_defaults
    set -U _tide_var_list
    set -a _tide_var_list _tide_file_list

    # -------------------Local Variables-------------------
    set -l tideColorGold D7AF00
    set -l tideColorDarkerGreen 5FAF00

    # ---------------General Theme Variables---------------
    _set _tide_dir "$__fish_config_dir/tide_theme"
    _set tide_newline 'true'
    # --------------Colors--------------
    _set _tide_color_green 5FD700
    _set _tide_color_light_blue 00AFFF
    _set _tide_color_dark_blue 0087AF
    # ---------Prompt Connection---------
    _set tide_prompt_connection_color 6C6C6C
    _set tide_prompt_connection_icon ' '

    # --------------------Prompt Items--------------------
    _set tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
    _set _tide_left_prompt_height 2
    _set tide_right_prompt_items 'status' 'cmd_duration' 'context' 'jobs'
    # ------------Prompt Char------------
    _set tide_prompt_char_success_color $_tide_color_green
    _set tide_prompt_char_failure_color FF0000
    _set tide_prompt_char_icon '❯'
    # ----------------Pwd----------------
    _set tide_pwd_truncate_margin 5
    _set tide_pwd_unwritable_icon '' # Lock
    _set tide_pwd_color_end_dirs $_tide_color_light_blue
    _set tide_pwd_color_mid_dirs $_tide_color_dark_blue
    _set tide_pwd_color_truncated_dirs 8787AF
    # ------------Git prompt------------
    _set __fish_git_prompt_show_informative_status true
    _set __fish_git_prompt_showstashstate true
    # -------Symbols-------
    _set __fish_git_prompt_char_stateseparator ''
    _set __fish_git_prompt_char_cleanstate ''
    _set __fish_git_prompt_char_upstream_ahead ' ⇡'
    _set __fish_git_prompt_char_upstream_behind ' ⇣'
    _set __fish_git_prompt_char_stagedstate ' +'
    _set __fish_git_prompt_char_dirtystate ' !'
    _set __fish_git_prompt_char_untrackedfiles ' ?'
    _set __fish_git_prompt_char_stashstate ' *'
    # --------Colors--------
    _set __fish_git_prompt_color_branch $_tide_color_green
    _set __fish_git_prompt_color_upstream $_tide_color_green
    _set __fish_git_prompt_color_stagedstate $tideColorGold
    _set __fish_git_prompt_color_dirtystate $tideColorGold
    _set __fish_git_prompt_color_untrackedfiles $_tide_color_light_blue
    _set __fish_git_prompt_color_stashstate $_tide_color_green
    # --------------Status--------------
    _set tide_status_success_icon '✔'
    _set tide_status_success_color $tideColorDarkerGreen
    _set tide_status_failure_icon '✘'
    _set tide_status_failure_color D70000
    # -----------Cmd_Duration-----------
    _set tide_cmd_duration_color 87875F
    _set tide_cmd_duration_decimals 0
    _set tide_cmd_duration_threshold 3000
    # --------------Context--------------
    _set tide_context_ssh_color D7AF87
    _set tide_context_root_color $tideColorGold
    # ---------------Jobs---------------
    _set tide_jobs_icon '' # Gear
    _set tide_jobs_color $tideColorDarkerGreen
    # ---------------Time---------------
    _set tide_time_color 5F8787
    _set tide_time_format '%T'
end

function _set -a var_name
    set -U $var_name $argv[2..-1]
    set -a _tide_var_list $var_name
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