function _tide_item_virtual_env
    if set -q VIRTUAL_ENV
        set_color $tide_virtual_env_color

        set -l splitVirtualEnv (string split '/' "$VIRTUAL_ENV")

        if test "$tide_virtual_env_display_mode" = 'projectName'
            printf '%s' {$tide_virtual_env_icon}' ' $splitVirtualEnv[-2]
        else if test "$tide_virtual_env_display_mode" = 'venvName'
            printf '%s' {$tide_virtual_env_icon}' ' $splitVirtualEnv[-1]
        end
    end
end