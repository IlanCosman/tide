function _tide_item_php
    test -e composer.json && _tide_print_item php (php --version | string match --regex 'PHP ([\d.]+)')[2]
end
