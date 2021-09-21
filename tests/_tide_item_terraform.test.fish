# RUN: %fish %s

function _terraform
    _tide_decolor (_tide_item_terraform)
end

set -l terraformDir (mktemp -d)
cd $terraformDir

mock terraform workspace show "echo 'default'"

_php # CHECK:

mkdir .terraform
_php # CHECK:

mock terraform workspace show "echo 'test'"
_php # CHECK: test

rm -r $terraformDir
