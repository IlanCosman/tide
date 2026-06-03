function _tide_item_php
    if path is $_tide_parent_dirs/composer.json
        if type -q herd
            set php_cmd "herd php"
        else
            set php_cmd "php"
        end

        eval $php_cmd --version | string match -qr "(?<v>[\d.]+)"
        _tide_print_item php $tide_php_icon' ' $v
    end
end
