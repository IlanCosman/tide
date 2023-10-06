function _tide_item_zig
    if path is $_tide_parent_dirs/build.zig
        zig version | string match -qr "(?<v>[\d.]+(-dev)?)"
        _tide_print_item zig $tide_zig_icon' ' $v
    end
end
