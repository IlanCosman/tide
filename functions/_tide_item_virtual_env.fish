function _tide_item_virtual_env
    if set -l splitVirtualEnv (string split '/' "$VIRTUAL_ENV")
        set_color $tide_virtual_env_color
        set -l directoryName (string split '/' (pwd))[-1]
        string match -qe $directoryName- $splitVirtualEnv[-1]; set pipenvStyle $status
        # Avoid printing a generic name
        if contains -- $splitVirtualEnv[-1] virtualenv venv .venv env
            printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-2]
        else if test $pipenvStyle -eq 0
            printf '%s' $tide_virtual_env_icon' ' $directoryName
        else
            printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-1]
        end
    end
end
