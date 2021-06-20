# RUN: %fish %s

function _shlvl
    _tide_decolor (fish -c _tide_item_shlvl)
end

if test (uname) = Darwin
    _shlvl # CHECK:  4

    set -lx tide_shlvl_threshold 4

    _shlvl # CHECK:
else
    _shlvl # CHECK:  2

    set -lx tide_shlvl_threshold 2

    _shlvl # CHECK:
end
