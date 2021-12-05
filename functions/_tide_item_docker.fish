function _tide_item_docker
    set -l context (_tide_item_docker_replace_ignore_result (docker context show 2>/dev/null)) &&
        test -n "$context" &&
        _tide_print_item docker $tide_docker_icon' ' $context
end

function _tide_item_docker_replace_ignore_result
    string replace --regex '^default$' '' $argv
    return 0
end
