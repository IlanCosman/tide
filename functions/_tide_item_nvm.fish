function _tide_item_nvm
    functions --query nvm && set -l nvmCurrent (nvm current) && if test "$nvmCurrent" != system
        set_color $tide_nvm_color
        printf '%s' $tide_nvm_icon' ' $nvmCurrent
    end
end