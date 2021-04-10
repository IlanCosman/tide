function _tide_find_and_remove -a name list --no-scope-shadowing
    set -l index (contains --index $name $$list) && set -e "$list"[$index]
end
