function _tide_item_nvm
    set -l nvm_current (nvm current)
    test "$nvm_current" != system && _tide_print_item nvm $tide_nvm_icon' ' $nvm_current
end
