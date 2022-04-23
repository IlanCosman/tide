function _tide_item_docker
    docker context inspect --format '{{.Name}}' | read -l context
    contains -- "$context" $tide_docker_default_contexts ||
        _tide_print_item docker $tide_docker_icon' ' $context
end
