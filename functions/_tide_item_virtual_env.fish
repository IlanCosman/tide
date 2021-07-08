function _tide_item_virtual_env
    if set -l splitVirtualEnv (string split '/' "$VIRTUAL_ENV")
        set_color $tide_virtual_env_color
        set -l pathSplit (string split '/' (pwd))
        # Does one of the path segments match the venvRoot implied by assuming
        # the virtualenv uses pipenv naming style?
        for pathSegment in $pathSplit[-1..1]
            if string match -qe "$pathSegment"- $splitVirtualEnv[-1]
                set venvRoot (string split -r -m1 '-' $splitVirtualEnv[-1])[1]
                break
            end
        end
        # Avoid printing a generic name
        if contains -- $splitVirtualEnv[-1] virtualenv venv .venv env
            printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-2]
        else if test (count $venvRoot) -eq 1
            printf '%s' $tide_virtual_env_icon' ' $venvRoot
        else
            printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-1]
        end
    end
end
