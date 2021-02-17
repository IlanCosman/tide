# RUN: %fish %s

function _nvm
    _tide_decolor (_tide_item_nvm)
end

set -lx tide_nvm_icon ⬢

mock nvm current "echo v15.8.0"
_nvm # CHECK: ⬢ v15.8.0

mock nvm current "echo system"
_nvm # CHECK:
