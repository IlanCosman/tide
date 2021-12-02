function _tide_item_php
    test -e composer.json && which php && _tide_print_item php $tide_php_icon' ' (php --version | string match --regex 'PHP ([\d.]+)')[2]
end
