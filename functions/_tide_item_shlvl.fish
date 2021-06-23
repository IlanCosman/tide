function _tide_item_shlvl
    # Item functions run in a deeper level of shell
    set -l real_shlvl (math $SHLVL - 1)
    test $real_shlvl -gt $tide_shlvl_threshold && _tide_print_item shlvl $tide_shlvl_icon' ' $real_shlvl
end
