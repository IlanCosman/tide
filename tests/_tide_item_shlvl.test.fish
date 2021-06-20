# RUN: %fish %s

function _shlvl
    _tide_decolor (_tide_item_shlvl)
end

set -lx SHLVL 2

_shlvl # CHECK: ↕️ 2

set -lx tide_shlvl_threshold 2

_shlvl # CHECK:
