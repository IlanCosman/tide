function _tide_decolor -a text
    string replace -a (set_color normal) '' "$text" | string replace -ar '\e\[[0-9;]*m' ''
end