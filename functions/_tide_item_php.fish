function _tide_item_php
    if path is $_tide_parent_dirs/composer.json
        php --version | string match -qr "(?<ver>[\d.]+)"
        _tide_print_item php "$tide_php_icon $ver"
    end
end
