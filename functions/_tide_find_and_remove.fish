function _tide_find_and_remove -a name list --no-scope-shadowing
    set -e "$list"[(contains --index $name $$list)] 2>/dev/null # Ignore error if $list doesn't contain $name
end
