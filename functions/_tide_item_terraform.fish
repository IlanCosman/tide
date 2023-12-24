function _tide_item_terraform
    path is $_tide_parent_dirs/.terraform &&
        terraform workspace show | string match -v default | read -l w &&
        _tide_print_item terraform $tide_terraform_icon' ' $w
end
