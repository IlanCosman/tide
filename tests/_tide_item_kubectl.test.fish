# RUN: %fish %s

function _kubectl
    _tide_decolor (_tide_item_kubectl)
end

set -lx tide_kubectl_icon ⎈

mock kubectl "config view --minify --output" "echo error: current-context must exist in order to minify >&2; false"
_kubectl # CHECK:

mock kubectl "config view --minify --output" "echo curr-context/default"
_kubectl # CHECK: ⎈ curr-context

mock kubectl "config view --minify --output" "echo curr-context/"
_kubectl # CHECK: ⎈ curr-context

mock kubectl "config view --minify --output" "echo curr-context/curr-namespace"
_kubectl # CHECK: ⎈ curr-context/curr-namespace
