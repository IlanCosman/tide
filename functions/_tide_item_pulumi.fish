function _tide_item_pulumi
    if test -e Pulumi.yaml
        if command -q sha1sum
            echo -n "$PWD/Pulumi.yaml" | sha1sum | string sub -e40 | read -f path_hash
        else if command -q shasum
            echo -n "$PWD/Pulumi.yaml" | shasum | string sub -e40 | read -f path_hash
        end

        if test -n "$path_hash"
            string match -rg 'name: *(.*)' <Pulumi.yaml | read -l project_name
            set -l workspace_file "$HOME/.pulumi/workspaces/$project_name-$path_hash-workspace.json"

            if test -e $workspace_file
                string match -rg '"stack": *"(.*)"' <$workspace_file | read -l stack
                _tide_print_item pulumi $tide_pulumi_icon' ' $stack
            end
        end
    end
end
