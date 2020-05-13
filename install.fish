function lean_install
    echo 'Installing lean theme...'

    # -----------------Download Functions-----------------
    set -l tempDir '/tmp/lean_theme'

    # Clone repository into $tempDir
    if test -e $tempDir
        rm -rf $tempDir
    end
    git clone -q --depth=1 https://github.com/IlanCosman/lean.git $tempDir

    # Remove all files/dirs except functions and lean_theme
    set -l keepFiles "$tempDir/"{'functions', 'lean_theme'}
    for file in $tempDir/*
        if not contains $file $keepFiles
            rm -rf $file
        end
    end
    rm -rf "$tempDir/.git"

    # Copy remaining directory contents into $__fish_config_dir and cleanup
    cp -rf "$tempDir/." $__fish_config_dir
    rm -rf $tempDir

    # --------------------Set Defaults--------------------
    _set_lean_defaults

    # -----------------------Finish-----------------------
    source "$__fish_config_dir/functions/fish_prompt.fish"

    set_color $lean_color_green
    echo 'Lean theme installed!'
    set_color $fish_color_normal

    if _user_confirm_defaultYes 'Configure lean prompt?'
        lean configure
    else
        echo
        echo 'Run lean configure to configure your prompt.'
    end
end

function _set_lean_defaults
    # ---------------General Theme Variables---------------
    set -U lean_dir "$__fish_config_dir/lean_theme"
    # --------------Colors--------------
    set -U lean_color_green 5FD700
    set -U lean_color_light_blue 00AFFF
    set -U lean_color_dark_blue 0087AF
    set -U lean_color_gold D7AF00
    set -U lean_color_lilac 8787AF
    # ---------Prompt Connection---------
    set -U lean_prompt_connection_color 6C6C6C
    set -U lean_prompt_connection_icon ' '

    # --------------------Prompt Items--------------------
    set -U lean_left_prompt_items 'pwd' 'git_prompt'
    set -U lean_right_prompt_items 'status' 'cmd_duration' 'context' 'jobs'
    # ----------------Pwd----------------
    set -U lean_pwd_shorten_margin 5
    set -U lean_pwd_unwritable_icon '' # Lock
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
    set -U __fish_git_prompt_color_branch $lean_color_green
    set -U __fish_git_prompt_color_upstream $lean_color_green
    set -U __fish_git_prompt_color_stagedstate $lean_color_gold
    set -U __fish_git_prompt_color_dirtystate $lean_color_gold
    set -U __fish_git_prompt_color_untrackedfiles $lean_color_light_blue
    set -U __fish_git_prompt_color_stashstate $lean_color_green
    # --------------Status--------------
    set -U lean_status_success_icon '✔'
    set -U lean_status_success_color 5FAF00
    set -U lean_status_failure_icon '✘'
    set -U lean_status_failure_color D70000
    # -----------Cmd_Duration-----------
    set -U lean_cmd_duration_color 87875F
    set -U lean_cmd_duration_decimals 0
    set -U lean_cmd_duration_threshold 3000
    # --------------Context--------------
    set -U lean_context_ssh_color D7AF87
    set -U lean_context_root_color D7AF00
    # ---------------Jobs---------------
    set -U lean_jobs_icon '' # Gear
    set -U lean_jobs_color 5FAF00
    # ---------------Time---------------
    set -U lean_time_color 5F8787
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