function _tide_item_crystal
    test -e shard.yml && _tide_print_item crystal $tide_crystal_icon' ' (crystal --version | string match -r "[\d.]+")[1]
end
