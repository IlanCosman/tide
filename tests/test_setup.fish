function _tide_decolor
    string replace --all --regex '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$argv"
end
funcsave _tide_decolor

echo "set TERM xterm-256color" >$__fish_config_dir/config.fish
