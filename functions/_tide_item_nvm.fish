function _tide_item_nvm
    set -l nvmCurrent (nvm current)
    test "$nvmCurrent" != system && _tide_print_item nvm $nvmCurrent
end
