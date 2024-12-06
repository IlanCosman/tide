function _tide_item_deno
    if path is $_tide_parent_dirs/deno.json
        deno --version | string match -qr "deno (?<v>.*) \(.*\)"
        _tide_print_item deno $tide_deno_icon' ' $v
    end
end
