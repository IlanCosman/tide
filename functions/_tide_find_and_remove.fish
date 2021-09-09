function _tide_find_and_remove -a name list --no-scope-shadowing
    contains --index $name $$list | read -l index && set -e "$list"[$index]
end
