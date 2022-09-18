function _tide_item_php
    path is $_tide_parent_dirs/composer.json &&
        _tide_print_item php $tide_php_icon' ' (php --version | string match -r 'PHP ([\d.]+)')[2]
end
