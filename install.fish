function tide_install
    printf '%s\n' 'Installing tide theme...'

    # -----------------Download Functions-----------------
    set -l tempDir '/tmp/tide_theme'

    # Clone repository into $tempDir
    if test -e $tempDir
        rm -rf $tempDir
    end
    git clone -q --depth=1 https://github.com/IlanCosman/tide.git $tempDir

    # Remove all files/dirs except functions and tide_theme
    set -l keepFiles "$tempDir/"{'conf.d', 'functions', 'tide_theme'}
    for file in $tempDir/*
        if not contains $file $keepFiles
            rm -rf $file
        end
    end
    rm -rf "$tempDir/.git"

    # Copy remaining directory contents into $__fish_config_dir and ctideup
    cp -rf "$tempDir/." $__fish_config_dir
    rm -rf $tempDir

    # --------------------Set Defaults--------------------
    _set_tide_defaults

    # -----------------------Finish-----------------------
    _source_tide_functions

    set_color $tide_color_green
    printf '%s\n' 'Tide theme installed!'
    set_color $fish_color_normal

    if _user_confirm_defaultYes 'Configure tide prompt?'
        tide configure
    else
        printf '%s\n'
        printf '%s\n' 'Run tide configure to configure your prompt.'
    end
end

function _set_tide_defaults
    set -U tide_var_list

    # -------------------Local Variables-------------------
    set -l tideColorGold D7AF00
    set -l tideColorDarkerGreen 5FAF00

    # ---------------General Theme Variables---------------
    _set tide_dir "$__fish_config_dir/tide_theme"
    _set tide_newline 'true'
    # --------------Colors--------------
    _set tide_color_green 5FD700
    _set tide_color_light_blue 00AFFF
    _set tide_color_dark_blue 0087AF
    # ---------Prompt Connection---------
    _set tide_prompt_connection_color 6C6C6C
    _set tide_prompt_connection_icon ' '

    # --------------------Prompt Items--------------------
    _set tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
    _set tide_left_prompt_height 2
    _set tide_right_prompt_items 'status' 'cmd_duration' 'context' 'jobs'
    # ------------Prompt Char------------
    _set tide_prompt_char_success_color $tide_color_green
    _set tide_prompt_char_failure_color FF0000
    _set tide_prompt_char_icon '❯'
    # ----------------Pwd----------------
    _set tide_pwd_shorten_margin 5
    _set tide_pwd_unwritable_icon '' # Lock
    _set tide_pwd_color_end_dirs $tide_color_light_blue
    _set tide_pwd_color_mid_dirs $tide_color_dark_blue
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
    _set __fish_git_prompt_color_branch $tide_color_green
    _set __fish_git_prompt_color_upstream $tide_color_green
    _set __fish_git_prompt_color_stagedstate $tideColorGold
    _set __fish_git_prompt_color_dirtystate $tideColorGold
    _set __fish_git_prompt_color_untrackedfiles $tide_color_light_blue
    _set __fish_git_prompt_color_stashstate $tide_color_green
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
    set -a tide_var_list $var_name
end

function _source_tide_functions
    source "$__fish_config_dir/conf.d/tide_count_left_prompt_height.fish"
    source "$__fish_config_dir/conf.d/tide_cursor_movement.fish"
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