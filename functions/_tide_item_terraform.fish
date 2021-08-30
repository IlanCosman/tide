function _tide_item_terraform
    test -d .terraform && _tide_print_item terraform $tide_terraform_icon' ' (terraform workspace show)
end
