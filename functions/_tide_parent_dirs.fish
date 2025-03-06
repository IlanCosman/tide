function _tide_parent_dirs --on-variable PWD
    set -g _tide_parent_dirs (
        string escape (
            for dir in (string split / -- $PWD)
                if test (string length \"$dir\") -lt 1
                    continue
                end
                set -a parts $dir
                string join "" (string join / --  $parts) ""
            end))
end
