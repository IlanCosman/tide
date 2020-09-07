function _tide_item_nvm
    if set -l whichNode (which node 2>/dev/null) # Ensure node is installed
        set -l nodeVersion (node --version)

        if test -n "$tide_nvm_default_node"
            if test "$tide_nvm_default_node" != "$nodeVersion"
                set_color $tide_nvm_color
                printf '%s' {$tide_nvm_icon}' ' $nodeVersion
            end
        else if string match --quiet --regex "^$NVM_DIR.*" $whichNode # If node path begins with nvm directory
            set_color $tide_nvm_color
            printf '%s' $tide_nvm_icon' ' $nodeVersion
        end
    end
end