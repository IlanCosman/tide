# RUN: %fish %s

function _docker
    _tide_decolor (_tide_item_docker)
end

set -lx tide_docker_icon 

mock docker "context inspect" "printf default"
_docker # CHECK:

mock docker "context inspect" "printf curr-context"
_docker # CHECK:  curr-context
