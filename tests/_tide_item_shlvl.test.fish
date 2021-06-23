# RUN: %fish %s
# REQUIRES: test $(uname) = Linux

function _shlvl
    _tide_decolor (fish -c _tide_item_shlvl)
end

_shlvl # CHECK:  2

set -lx tide_shlvl_threshold 2

_shlvl # CHECK:
