function tide_uninstall
    if not _user_confirm_defaultNo 'Uninstall tide theme?'
        printf '%s\n' 'Aborted uninstall.'
        return 1
    end
    printf '%s\n' 'Uninstalling tide theme...'

    set -l fishPrompt (functions -D fish_prompt)

    # ----------------------------------Remove Files----------------------------------
    if test -e $_tide_dir
        rm -r $_tide_dir
    end

    set -l fishPromptFirstLine (head -n 1 $fishPrompt)
    if test "$fishPromptFirstLine" = '# Created by tide configure'
        rm $fishPrompt
        source "$__fish_data_dir/functions/fish_prompt.fish"
    end

    for file in $_tide_file_list
        rm -f "$__fish_config_dir/$file"
    end

    # -----------------------------Erase Theme Variables------------------------------
    for var in $_tide_var_list
        set -e $var
    end
    set -e _tide_var_list

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