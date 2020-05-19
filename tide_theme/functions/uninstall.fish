function tide_uninstall
    if not _user_confirm_defaultNo 'Uninstall tide theme?'
        echo 'Aborted uninstall.'
        return 1
    end
    echo 'Uninstalling tide theme...'

    set -l fishPrompt (functions -D fish_prompt)

    # ----------------------------------Remove Files----------------------------------
    if test -e $tide_dir
        rm -r $tide_dir
    end

    set -l fishPromptFirstLine (head -n 1 $fishPrompt)
    if test "$fishPromptFirstLine" = '# Created by tide configure'
        rm $fishPrompt
        source "$__fish_data_dir/functions/fish_prompt.fish"
    end

    set -a tideFunctions 'tide'
    set -a tideFunctions 'tide_'{'decolor', 'left_prompt', 'right_prompt'}
    set -a tideFunctions '_tide_'{'cmd_duration', 'context', 'git_prompt', 'jobs', 'newline', 'prompt_char', 'pwd', 'status', 'time'}
    for func in $tideFunctions
        rm "$__fish_config_dir/functions/$func.fish"
    end

    set -a tideConfd 'tide_'{'count_left_prompt_height', 'cursor_movement'}
    for file in $tideConfd
        rm "$__fish_config_dir/conf.d/$file.fish"
    end

    # -----------------------------Erase Theme Variables------------------------------
    set -l rmVars \
        # ---------------General Theme Variables---------------
        'tide'{'dir', 'newline'} \
        # --------------Colors--------------
        'tide_color_'{'green', 'light_blue', 'dark_blue', 'gold', 'lilac'} \
        # ---------Prompt Connection---------
        'tide_prompt_connection_'{'icon', 'color'} \
        # --------------------Prompt Items--------------------
        'tide_'{'right_prompt_items', 'left_prompt_items', 'left_prompt_height'} \
        # ----------------Pwd----------------
        'tide_pwd_'{'shorten_margin', 'unwritable_icon'} \
        # ------------Git prompt------------
        '__fish_git_prompt_'{'show_informative_status', 'showstashstate'} \
        # -------Symbols-------
        '__fish_git_prompt_char_'{'stateseparator', 'ctidestate', 'upstream_ahead', 'upstream_behind'} \
        '__fish_git_prompt_char_'{'stagedstate', 'dirtystate', 'untrackedfiles', 'stashstate'} \
        # --------Colors--------
        '__fish_git_prompt_color_'{'branch', 'upstream', 'stagedstate', 'dirtystate', 'untrackedfiles', 'stashstate'} \
        # --------------Status--------------
        'tide_status_'{'success_icon', 'success_color', 'failure_icon', 'failure_color'} \
        # ------------Cmd_Duration-----------
        'tide_cmd_duration_'{'color', 'decimals', 'threshold'} \
        # ----------------SSH----------------
        'tide_context_'{'ssh_color', 'root_color'} \
        # ---------------Jobs---------------
        'tide_jobs_'{'icon', 'color'} \
        # ---------------Time---------------
        'tide_time_'{'format', 'color'}

    for var in $rmVars
        set -e $var
    end

    echo 'Tide theme uninstalled.'
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