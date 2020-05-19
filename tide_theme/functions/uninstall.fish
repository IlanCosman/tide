function tide_uninstall
    if not _user_confirm_defaultNo 'Uninstall tide theme?'
        printf '%s\n' 'Aborted uninstall.'
        return 1
    end
    printf '%s\n' 'Uninstalling tide theme...'

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
    for var in $tide_var_list
        set -e $var
    end
    set -e tide_var_list

    printf '%s\n' 'Tide theme uninstalled.'
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