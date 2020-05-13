function lean_uninstall
    if not _user_confirm_defaultNo 'Uninstall lean theme?'
        echo 'Aborted uninstall.'
        return 1
    end
    echo 'Uninstalling lean theme...'

    set -l fishPrompt (functions -D fish_prompt)

    # ----------------------------------Remove Files----------------------------------
    if test -e $lean_dir
        rm -r $lean_dir
    end

    set -l fishPromptFirstLine (head -n 1 $fishPrompt)
    if test "$fishPromptFirstLine" = '# Created by lean configure'
        rm $fishPrompt
        source "$__fish_data_dir/functions/fish_prompt.fish"
    end

    set -a leanFunctions 'lean'
    set -a leanFunctions 'lean_'{'decolor', 'left_prompt', 'right_prompt'}
    set -a leanFunctions '_lean_'{'cmd_duration', 'context', 'git_prompt', 'jobs', 'pwd', 'status', 'time'}
    for func in $leanFunctions
        rm "$__fish_config_dir/functions/$func.fish"
    end

    # -----------------------------Erase Theme Variables------------------------------
    set -l rmVars \
        # ---------------General Theme Variables---------------
        'lean_dir' \
        # --------------Colors--------------
        'lean_color_'{'green', 'light_blue', 'dark_blue', 'gold', 'lilac'} \
        # ---------Prompt Connection---------
        'lean_prompt_connection_'{'icon', 'color'} \
        # --------------------Prompt Items--------------------
        'lean_'{'right_prompt_items', 'left_prompt_items'} \
        # ----------------Pwd----------------
        'lean_pwd_'{'shorten_margin', 'unwritable_icon'} \
        # ------------Git prompt------------
        '__fish_git_prompt_'{'show_informative_status', 'showstashstate'} \
        # -------Symbols-------
        '__fish_git_prompt_char_'{'stateseparator', 'cleanstate', 'upstream_ahead', 'upstream_behind'} \
        '__fish_git_prompt_char_'{'stagedstate', 'dirtystate', 'untrackedfiles', 'stashstate'} \
        # --------Colors--------
        '__fish_git_prompt_color_'{'branch', 'upstream', 'stagedstate', 'dirtystate', 'untrackedfiles', 'stashstate'} \
        # --------------Status--------------
        'lean_status_'{'success_icon', 'success_color', 'failure_icon', 'failure_color'} \
        # ------------Cmd_Duration-----------
        'lean_cmd_duration_'{'color', 'decimals', 'threshold'} \
        # ----------------SSH----------------
        'lean_context_'{'ssh_color', 'root_color'} \
        # ---------------Jobs---------------
        'lean_jobs_'{'icon', 'color'} \
        # ---------------Time---------------
        'lean_time_'{'format', 'color'}

    for var in $rmVars
        set -e $var
    end

    echo 'Lean theme uninstalled.'
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