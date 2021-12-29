function _tide_item_rvm
    if test -e .ruby-version
        _tide_print_item rvm $tide_rvm_icon' ' (rvm current)
    end
end
