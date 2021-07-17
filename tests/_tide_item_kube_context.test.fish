# RUN: %fish %s

function _kube_context
    _tide_decolor (_tide_item_kube_context)
end

set -lx tide_kube_context_icon ⎈

mock kubectl "config view --minify --output" "echo error: current-context must exist in order to minify >&2"
_kube_context # CHECK:

mock kubectl "config view --minify --output" "printf curr-context/default"
_kube_context # CHECK: ⎈ curr-context

mock kubectl "config view --minify --output" "printf curr-context/curr-namespace"
_kube_context # CHECK: ⎈ curr-context/curr-namespace
