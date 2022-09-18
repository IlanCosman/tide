function _tide_item_go
    path is $_tide_parent_dirs/go.mod &&
        _tide_print_item go $tide_go_icon' ' (go version | string match -r "[\d.]+")
end
