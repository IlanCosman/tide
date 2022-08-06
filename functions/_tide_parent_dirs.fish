function _tide_parent_dirs --on-variable PWD
    set -g _tide_parent_dirs (for dir in (string split / $PWD)
        set -la parts $dir
        string join / $parts
    end)
end
