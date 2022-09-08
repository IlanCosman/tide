function _tide_item_toolbox
    test -e /run/.toolboxenv && _tide_print_item toolbox $tide_toolbox_icon' ' $(cat /run/.containerenv | sed -n '2 p' | awk -F '"' 'NF>2{print $2}')
end
