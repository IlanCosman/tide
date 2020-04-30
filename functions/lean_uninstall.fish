function lean_uninstall
    if _user_confirm_defaultNo 'Unininstall lean theme?'
        set -l fishPrompt "$__fish_config_dir/functions/fish_prompt.fish"

        echo 'Uninstalling lean theme...'

        # ------------------Remove Files------------------
        rm -r "$__fish_config_dir/lean_theme"

        set -l fishPromptFirstLine (head -n 1 $fishPrompt)
        if test "$fishPromptFirstLine" = '# Created by lean_wizard'
            rm $fishPrompt
            source "$__fish_data_dir/functions/fish_prompt.fish"
        end

        set -l leanFunctions git_prompt load_right_prompt_items pwd right_prompt uninstall wizard
        for func in $leanFunctions
            rm "$__fish_config_dir/functions/lean_$func.fish"
        end

        # --------------Erase Theme Variables--------------
        # --------------Prompt--------------
        set -a rmVars lean_prompt_connection_{icon, color}
        # --------------Colors--------------
        set -a rmVars lean_color_{green, light_blue, dark_blue, gold}
        # ---------------Pwd---------------
        set -a rmVars lean_pwd_{shorten_margin, unwritable_icon}
        # ------------Git prompt------------
        set -a rmVars __fish_git_prompt_{show_informative_status, showstashstate}
        # -------Symbols-------
        set -a rmVars __fish_git_prompt_char_{stateseparator, cleanstate, upstream_ahead, upstream_behind}
        set -a rmVars __fish_git_prompt_char_{stagedstate, dirtystate, untrackedfiles, stashstate}
        # --------Colors--------
        set -a rmVars __fish_git_prompt_color_{branch, upstream, stagedstate, dirtystate, untrackedfiles, stashstate}

        # ----------------Right Prompt Items----------------
        set -a rmVars lean_right_prompt_items
        # --------------Status--------------
        set -a rmVars lean_status_{success_icon, success_color, failure_icon, failure_color}
        # --------------Cmd_Duration--------------
        set -a rmVars lean_cmd_duration_{color, decimals, duration}
        # ---------------SSH---------------
        set -a rmVars lean_context_{ssh_color, root_color}
        # ---------------Jobs---------------
        set -a rmVars lean_jobs_{icon, color}

        for var in $rmVars
            set -e $var
        end

        echo 'Lean theme uninstalled.'
    else
        echo 'Aborted uninstall.'
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