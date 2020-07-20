function _tide_decolor -a text
    string replace --all $_tide_color_normal '' "$text" | string replace --all --regex '\e\[[0-9;]*m' ''
end