function _tide_item_virtual_env
    if set -l splitVirtualEnv (string split '/' "$VIRTUAL_ENV")
        set_color $tide_virtual_env_color

        # Detect if the virtualenv was spawned by poetry
        # then _OLD_VIRTUAL_PATH is set and VIRTUAL_ENV has the form
        # /home/<user>/.cache/pypoetry/virtualenvs/myproject-j_EvlIcP-py3.8
        if test -n "$_OLD_VIRTUAL_PATH"; and test $splitVirtualEnv[-3] = 'pypoetry'
            # This is needed when the project name has a dash in it, e.g. fish-shell
            # Split by - and discard the last two parts
            set -l splitPoetryVirtualEnv (string split '-' $splitVirtualEnv[-1])
            set -l poetryVirtualEnvName (string join '-' $splitPoetryVirtualEnv[1..-3])
            printf '%s' $tide_virtual_env_icon' ' $poetryVirtualEnvName
        else
            if test "$tide_virtual_env_display_mode" = 'venvName'
                printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-1]
            else # Default to projectName
                printf '%s' $tide_virtual_env_icon' ' $splitVirtualEnv[-2]
            end
        end
    else if test -n "$CONDA_DEFAULT_ENV"
        # conda uses CONDA_DEFAULT_ENV instead of VIRTUAL_ENV
        printf '%s' $tide_virtual_env_icon' ' $CONDA_DEFAULT_ENV
    end
end