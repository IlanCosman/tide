# RUN: %fish %s
_tide_parent_dirs

function _jj
    _tide_decolor (_tide_item_jj)
end

function _mock_jj
    set -g _jjfields $argv
    function jj --inherit-variable _jjfields
        test "$argv[1]" = root && return 0
        printf '%s\0' $_jjfields
    end
end

function jj
    return 1
end
_jj # CHECK:

# Clean, empty working copy (change + commit ids only)
_mock_jj q '' z '' '' '' 1 '' '' '' 0 0 0
_jj # CHECK: jj q z

# Bookmark, description and diff stats
_mock_jj ab c de f main 'fix parser' '' '' '' '' 2 40 3
_jj # CHECK: jj abc def main "fix parser" +40 -3

# Conflict
_mock_jj xy '' zz '' '' '' '' 1 '' '' 1 5 0
_jj # CHECK: jj xy zz conflict +5 -0

# Divergent, no diff
_mock_jj mm '' nn '' '' '' '' '' 1 '' 0 0 0
_jj # CHECK: jj mm nn divergent
