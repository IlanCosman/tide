function _tide_item_pulumi
    if path filter $_tide_parent_dirs/Pulumi.yaml | read -l yaml_path
        if command -q sha1sum
            echo -n "$yaml_path" | sha1sum | string sub -e40 | read -f path_hash
        else if command -q shasum
            echo -n "$yaml_path" | shasum | string sub -e40 | read -f path_hash
        end

        if test -n "$path_hash"
            string match -rg 'name: *(.*)' <$yaml_path | read -l project_name
            set -l workspace_file "$HOME/.pulumi/workspaces/$project_name-$path_hash-workspace.json"

            if test -e $workspace_file
                string match -rg '"stack": *"(.*)"' <$workspace_file | read -l stack
                _tide_print_item pulumi $tide_pulumi_icon' ' $stack
            end
        end
    end
end
