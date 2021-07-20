function _tide_item_kubectl
    set -l context (kubectl config view --minify --output 'jsonpath={.current-context}/{..namespace}' 2>/dev/null) &&
        _tide_print_item kubectl $tide_kubectl_icon' ' (string replace --regex '/(|default)$' '' $context)
end
