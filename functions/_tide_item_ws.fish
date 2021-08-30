function _tide_item_ws
    test -n "$WS_ENVIRONMENT" && _tide_print_item node $tide_ws_icon' ' (ws show)
end
