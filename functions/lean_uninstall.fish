function lean_uninstall
    if _user_confirm_defaultNo "Unininstall lean theme?"
        echo "Uninstalling lean theme..."

        # ------------------Remove Files------------------
        rm "$__fish_config_dir/functions/fish_prompt.fish"
        rm "$__fish_config_dir/functions/lean"*
        rm -r "$__fish_config_dir/lean_theme"

        # --------------Erase Theme Variables--------------
        # --------------Prompt--------------
        set -a vars lean_prompt_connection lean_prompt_connection_color
        # --------------Colors--------------
        set -a vars lean_color_{green, light_blue, dark_blue, gold}
        # ---------------Pwd---------------
        set -a vars fish_prompt_pwd_dir_length lean_shorten_pwd_margin
        # ------------Git prompt------------
        set -a vars __fish_git_prompt_{show_informative_status, showstashstate}
        # -------Symbols-------
        set -a vars __fish_git_prompt_char_{stateseparator, cleanstate, upstream_ahead, upstream_behind}
        set -a vars __fish_git_prompt_char_{stagedstate, dirtystate, untrackedfiles, stashstate}
        # --------Colors--------
        set -a vars __fish_git_prompt_color_{branch, upstream, stagedstate, dirtystate, untrackedfiles, stashstate}

        # ----------------Right Prompt Modules----------------
        set -a vars lean_right_prompt_modules
        # --------------Timer--------------
        set -a vars lean_timer_{color, decimals, duration}
        # ---------------SSH---------------
        set -a vars lean_ssh_color

        for var in $vars
            set -e $var
        end

        echo "Lean theme uninstalled. Exiting fish."
        sleep 1
        exit
    else
        echo "Aborted uninstall."
    end
end

function _user_confirm_defaultNo --argument-names question
    while true
        read -P "$question [y/N] " input

        switch $input
            case y Y yes Yes
                return 0
            case n N no No
                return 1
            case ''
                return 1
        end
    end
end