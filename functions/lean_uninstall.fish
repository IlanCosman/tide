function lean_uninstall
    if _user_confirm_defaultNo "Unininstall lean theme?"
        echo "Uninstalling lean theme..."

        # ------------------Remove Files------------------
        rm -r "$__fish_config_dir/lean_theme"

        set -l fishPromptFirstLine (head -n 1 "$__fish_config_dir/functions/fish_prompt.fish")
        if test "$fishPromptFirstLine" = "# Created by lean_wizard"
            rm "$__fish_config_dir/functions/fish_prompt.fish"
        end

        set -l leanFunctions git_prompt load_right_prompt_items pwd right_prompt uninstall wizard
        for func in $leanFunctions
            rm "$__fish_config_dir/functions/lean_$func.fish"
        end

        # --------------Erase Theme Variables--------------
        # --------------Prompt--------------
        set -a rmVars lean_prompt_connection lean_prompt_connection_color
        # --------------Colors--------------
        set -a rmVars lean_color_{green, light_blue, dark_blue, gold}
        # ---------------Pwd---------------
        set -a rmVars fish_prompt_pwd_dir_length lean_shorten_pwd_margin
        # ------------Git prompt------------
        set -a rmVars __fish_git_prompt_{show_informative_status, showstashstate}
        # -------Symbols-------
        set -a rmVars __fish_git_prompt_char_{stateseparator, cleanstate, upstream_ahead, upstream_behind}
        set -a rmVars __fish_git_prompt_char_{stagedstate, dirtystate, untrackedfiles, stashstate}
        # --------Colors--------
        set -a rmVars __fish_git_prompt_color_{branch, upstream, stagedstate, dirtystate, untrackedfiles, stashstate}

        # ----------------Right Prompt Items----------------
        set -a rmVars lean_right_prompt_items
        # --------------Timer--------------
        set -a rmVars lean_timer_{color, decimals, duration}
        # ---------------SSH---------------
        set -a rmVars lean_ssh_color

        for var in $rmVars
            set -e $var
        end

        echo "Lean theme uninstalled. Exiting fish."
        sleep 1
        exit
    else
        echo "Aborted uninstall."
    end
end

function _user_confirm_defaultNo -a question
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