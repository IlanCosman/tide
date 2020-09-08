function _tide_item_virtual_env
    if set -l splitVirtualEnv (string split '/' "$VIRTUAL_ENV")
        set_color $tide_virtual_env_color

        if test "$tide_virtual_env_display_mode" = 'venvName'
            printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-1]
        else # Default to projectName
            printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-2]
        end
    end
end