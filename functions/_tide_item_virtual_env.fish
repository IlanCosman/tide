function _tide_item_virtual_env
    if set -l splitVirtualEnv (string split '/' "$VIRTUAL_ENV")
        set_color $tide_virtual_env_color
        # Avoid printing a generic name
        if contains -- $splitVirtualEnv[-1] virtualenv venv .venv env
            printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-2]
        else if string match -qe "$HOME/.local/share/virtualenvs/" $VIRTUAL_ENV
            printf '%s' $tide_virtual_env_icon' ' (string split -r -m1 '-' $splitVirtualEnv[-1])[1]
        else
            printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-1]
        end
    end
end
