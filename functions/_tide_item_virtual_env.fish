function _tide_item_virtual_env
    if set -l splitVirtualEnv (string split '/' "$VIRTUAL_ENV")
        set_color $tide_virtual_env_color
        # Avoid printing a generic name
        if contains -- $splitVirtualEnv[-1] virtualenv venv .venv env
            printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-2]
        else
            printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-1]
        end
    end
end
