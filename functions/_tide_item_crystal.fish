function _tide_item_crystal
    path is $_tide_parent_dirs/shard.yml &&
        _tide_print_item crystal $tide_crystal_icon' ' (crystal --version | string match -r "[\d.]+")[1]
end
