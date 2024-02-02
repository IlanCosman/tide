function _tide_item_aws_vault
    if test -n "$AWS_VAULT"
        _tide_print_item aws_vault $tide_aws_vault_icon' ' "$AWS_VAULT"
    end
end
