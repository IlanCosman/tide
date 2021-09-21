function _tide_item_terraform
    if test -d .terraform
        set -l workspace (terraform workspace show)
        test $workspace != 'default' && _tide_print_item terraform $tide_terraform_icon' ' $workspace
    end
end
