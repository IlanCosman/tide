function _tide_item_go
    if test -e go.mod
        set_color $tide_go_color
        printf '%s' $tide_go_icon' ' (go version | string split ' ')[3]
    end
end
