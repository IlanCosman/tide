function _tide_item_aws
    # AWS_PROFILE overrides AWS_DEFAULT_PROFILE, AWS_REGION overrides AWS_DEFAULT_REGION
    set -q AWS_PROFILE && set -l AWS_DEFAULT_PROFILE $AWS_PROFILE
    set -q AWS_REGION && set -l AWS_DEFAULT_REGION $AWS_REGION

    if test -n "$AWS_DEFAULT_PROFILE" && test -n "$AWS_DEFAULT_REGION"
        _tide_print_item aws $tide_aws_icon' ' "$AWS_DEFAULT_PROFILE/$AWS_DEFAULT_REGION"
    else if test -n "$AWS_DEFAULT_PROFILE$AWS_DEFAULT_REGION"
        _tide_print_item aws $tide_aws_icon' ' "$AWS_DEFAULT_PROFILE$AWS_DEFAULT_REGION"
    end
end
