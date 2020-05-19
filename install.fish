function tide_install
    echo 'Installing tide theme...'

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
    echo 'Tide theme installed!'
    set_color $fish_color_normal

    if _user_confirm_defaultYes 'Configure tide prompt?'
        tide configure
    else
        echo
        echo 'Run tide configure to configure your prompt.'
    end
end

function _set_tide_defaults
    # ---------------General Theme Variables---------------
    set -U tide_dir "$__fish_config_dir/tide_theme"
    set -U tide_newline 'true'
    # --------------Colors--------------
    set -U tide_color_green 5FD700
    set -U tide_color_light_blue 00AFFF
    set -U tide_color_dark_blue 0087AF
    set -U tide_color_gold D7AF00
    set -U tide_color_lilac 8787AF
    # ---------Prompt Connection---------
    set -U tide_prompt_connection_color 6C6C6C
    set -U tide_prompt_connection_icon ' '

    # --------------------Prompt Items--------------------
    set -U tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
    set -U tide_right_prompt_items 'status' 'cmd_duration' 'context' 'jobs'
    # ----------------Pwd----------------
    set -U tide_pwd_shorten_margin 5
    set -U tide_pwd_unwritable_icon '' # Lock
    # ------------Git prompt------------
    set -U __fish_git_prompt_show_informative_status true
    set -U __fish_git_prompt_showstashstate true
    # -------Symbols-------
    set -U __fish_git_prompt_char_stateseparator ''
    set -U __fish_git_prompt_char_cleanstate ''
    set -U __fish_git_prompt_char_upstream_ahead ' ⇡'
    set -U __fish_git_prompt_char_upstream_behind ' ⇣'
    set -U __fish_git_prompt_char_stagedstate ' +'
    set -U __fish_git_prompt_char_dirtystate ' !'
    set -U __fish_git_prompt_char_untrackedfiles ' ?'
    set -U __fish_git_prompt_char_stashstate ' *'
    # --------Colors--------
    set -U __fish_git_prompt_color_branch $tide_color_green
    set -U __fish_git_prompt_color_upstream $tide_color_green
    set -U __fish_git_prompt_color_stagedstate $tide_color_gold
    set -U __fish_git_prompt_color_dirtystate $tide_color_gold
    set -U __fish_git_prompt_color_untrackedfiles $tide_color_light_blue
    set -U __fish_git_prompt_color_stashstate $tide_color_green
    # --------------Status--------------
    set -U tide_status_success_icon '✔'
    set -U tide_status_success_color 5FAF00
    set -U tide_status_failure_icon '✘'
    set -U tide_status_failure_color D70000
    # -----------Cmd_Duration-----------
    set -U tide_cmd_duration_color 87875F
    set -U tide_cmd_duration_decimals 0
    set -U tide_cmd_duration_threshold 3000
    # --------------Context--------------
    set -U tide_context_ssh_color D7AF87
    set -U tide_context_root_color D7AF00
    # ---------------Jobs---------------
    set -U tide_jobs_icon '' # Gear
    set -U tide_jobs_color 5FAF00
    # ---------------Time---------------
    set -U tide_time_color 5F8787
end

function _source_tide_functions
    source "$__fish_config_dir/conf.d/tide_count_left_prompt_height.fish"
    source "$__fish_config_dir/conf.d/tide_cursor_movement.fish"
    source "$__fish_config_dir/functions/fish_prompt.fish"

    tide_count_left_prompt_height
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