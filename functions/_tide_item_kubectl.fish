function _tide_item_kubectl
    kubectl config view --minify --output 'jsonpath={.current-context}/{..namespace}' 2>/dev/null | read -l context &&
        _tide_print_item kubectl $tide_kubectl_icon' ' (string replace -r '/(|default)$' '' $context)
end
