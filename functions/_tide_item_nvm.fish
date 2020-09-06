function _tide_node_version
    function top_level_dir --argument-names dirPath
	echo (string split --max 2 / $dirPath)[2]
    end

    set -l node_path_begin (top_level_dir (which node 2>/dev/null))
    set -l home_path_begin (top_level_dir $HOME)

    if test $node_path_begin = $home_path_begin;
	echo (node --version)
    else;
	echo "system"
    end
end

function _tide_item_nvm
    set -l node_version (_tide_node_version)

    if test "$node_version" != "system" -a -n "$node_version"
        set_color $tide_nvm_color
        printf '%s ' "$tide_nvm_icon $node_version"
    end
end
