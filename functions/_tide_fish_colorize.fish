function _tide_fish_colorize
    if command -q fish_indent
        echo -ns "$argv" | fish_indent --ansi
    else
        echo -ns "$argv"
    end
end
