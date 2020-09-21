function _tide_decolor -a text
    string replace --all --regex '\e(\[[\d;]*|\(B\e\[)m' '' "$text"
end