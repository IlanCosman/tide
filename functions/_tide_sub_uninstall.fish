function _tide_sub_uninstall
    if not _tide_user_confirm_defaultNo 'Uninstall tide?'
        printf '%s\n' 'Aborted uninstall.'
        return 1
    end
    printf '%s\n' 'Uninstalling tide...'

    # ----------------------------------Remove Files----------------------------------
    rm -r $_tide_dir

    if test (functions --details --verbose fish_prompt)[5] = 'Created by tide configure'
        rm (functions --details fish_prompt)
        source "$__fish_data_dir/functions/fish_prompt.fish"
    end

    functions -e (basename -s '.fish' $_tide_file_list)

    rm $__fish_config_dir/$_tide_file_list

    # -----------------------------Erase Theme Variables------------------------------
    for var in $_tide_var_immutable_list $_tide_var_list
        set -e $var
    end
    set -e _tide_var_immutable_list
    set -e _tide_var_list

    printf '%s\n' 'Tide uninstalled.'
end

function _tide_user_confirm_defaultNo -a question
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