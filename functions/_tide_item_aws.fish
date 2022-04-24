function _tide_item_aws
    # AWS_PROFILE overrides AWS_DEFAULT_PROFILE
    set -q AWS_DEFAULT_PROFILE && set -f _profile_name $AWS_DEFAULT_PROFILE
    set -q AWS_PROFILE && set -f _profile_name $AWS_PROFILE
    # AWS_REGION overrides AWS_DEFAULT_REGION
    set -q AWS_DEFAULT_REGION && set -f _region_name $AWS_DEFAULT_REGION
    set -q AWS_REGION && set -f _region_name $AWS_REGION

    if test -n "$_profile_name" && test -n "$_region_name"
        _tide_print_item aws $tide_aws_icon' ' "$_profile_name"/"$_region_name"
    else if test -n "$_profile_name" || test -n "$_region_name"
        _tide_print_item aws $tide_aws_icon' ' "$_profile_name""$_region_name"
    end
end
