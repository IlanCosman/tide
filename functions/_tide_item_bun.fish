function _tide_item_bun
    path is $_tide_parent_dirs/bun.lock &&
        _tide_print_item bun $tide_bun_icon' ' (bun --version)
end
