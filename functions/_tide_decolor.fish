function _tide_decolor -a text
    string replace -a $_tide_color_normal '' "$text" | string replace -ar '\e\[[0-9;]*m' ''
end