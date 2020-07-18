function _tide_item_nvm
    test 
    set -l node_version (functions -q nvm; and nvm current)

    if test "$node_version" != "none" -a "$node_version" != "system" -a -n "$node_version"
        set_color $tide_nvm_color
        printf '%s ' "$tide_nvm_icon $node_version"
    end
end
