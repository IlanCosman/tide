function _tide_item_kube_context
    set -l context (kubectl config view --minify --output 'jsonpath={.current-context}/{..namespace}' 2>/dev/null)
    test -n "$context" && _tide_print_item kube_context $tide_kube_context_icon' ' (string replace -r '/(?:default)?$' '' $context)
end
