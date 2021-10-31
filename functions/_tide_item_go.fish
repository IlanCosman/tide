function _tide_item_go
    test -e go.mod && _tide_print_item go $tide_go_icon' ' (go version | string match -r "[\d.]+")
end
