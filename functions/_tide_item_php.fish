function _tide_item_php
    if test -e composer.json
        set_color $tide_php_color
        printf '%s' $tide_php_icon' ' (php --version | string match --regex 'PHP ([\d.]+)')[2]
    end
end
