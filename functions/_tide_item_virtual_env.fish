function _tide_item_virtual_env
    if set -q VIRTUAL_ENV
        if test "$tide_virtual_env_display" = 'projectName'
            set output (basename (string split -r -m1 '/' "$VIRTUAL_ENV")[1])
        else if test "$tide_virtual_env_display" = 'venvName'
            set output (basename "$VIRTUAL_ENV")
        end

        set_color $tide_virtual_env_color
        printf '%s ' "$tide_virtual_env_icon $output"
    end
end