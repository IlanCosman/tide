# RUN: %fish %s

function _aws
    _tide_decolor (_tide_item_aws)
end

_aws # CHECK:

set -lx tide_aws_icon 
set -lx AWS_DEFAULT_PROFILE default_profile

_aws # CHECK:  default_profile

set -lx AWS_DEFAULT_REGION default_region

_aws # CHECK:  default_profile/default_region

set -lx AWS_PROFILE non_default_profile
set -lx AWS_REGION non_default_region

_aws # CHECK:  non_default_profile/non_default_region

set -e AWS_REGION
set -e AWS_PROFILE
set -e AWS_DEFAULT_PROFILE

_aws # CHECK:  default_region
