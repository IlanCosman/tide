function _tide_item_node
    test -e package.json && _tide_print_item node $tide_node_icon' ' (node --version | string trim --chars=v)
end
