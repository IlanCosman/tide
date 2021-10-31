function _tide_decolor
    string replace --all -r '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$argv"
end
funcsave _tide_decolor

echo "\
set TERM xterm-256color
set -g _tide_side right" >$__fish_config_dir/config.fish
