# RUN: %fish %s
_tide_parent_dirs

function _terraform
    _tide_decolor (_tide_item_terraform)
end

set -l terraformDir (mktemp -d)
cd $terraformDir

mock terraform "workspace show" "echo default"
_terraform # CHECK:

mkdir .terraform
_terraform # CHECK:

mock terraform "workspace show" "echo test"
_terraform # CHECK: test

command rm -r $terraformDir
