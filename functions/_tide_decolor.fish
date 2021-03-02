function _tide_decolor
    string replace --all --regex '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$argv"
end
