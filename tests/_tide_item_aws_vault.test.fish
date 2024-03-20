# RUN: %fish %s
_tide_parent_dirs

function _aws_vault
    _tide_decolor (_tide_item_aws_vault)
end

set -lx tide_aws_vault_icon 

_aws_vault # CHECK:

set -lx AWS_VAULT TestAcc1

_aws_vault # CHECK:  TestAcc1

set -lx AWS_VAULT TestAcc2

_aws_vault # CHECK:  TestAcc2
