# RUN: %fish %s
_tide_parent_dirs

function _direnv
    _tide_decolor (_tide_item_direnv)
end

set -e DIRENV_DIR
set -lx tide_direnv_icon ▼

_direnv # CHECK:

set -lx DIRENV_DIR
mock direnv status "echo Found RC allowed true"
_direnv # CHECK: ▼

mock direnv status "echo Found RC allowed false"
_direnv # CHECK: ▼
