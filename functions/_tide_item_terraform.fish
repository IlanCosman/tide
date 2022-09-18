function _tide_item_terraform
    if path is $_tide_parent_dirs/.terraform
        terraform workspace show | read -l workspace
        test $workspace != default && _tide_print_item terraform $tide_terraform_icon' ' $workspace
    end
end
