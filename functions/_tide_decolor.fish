function _tide_decolor -a text
    printf '%s' "$text" | string replace -a (set_color normal) '' | string replace -ar '\e\[[0-9;]*m' ''
end