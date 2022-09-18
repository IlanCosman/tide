function _tide_item_pulumi
    if test -e Pulumi.yaml
        set -l project_name (string match -rg 'name: ([^ ]+)' < Pulumi.yaml)
        set -l yaml_path (pwd)/Pulumi.yaml

        set -l path_hash ''
        if command -q sha1sum
            set path_hash (echo -n "$yaml_path" | sha1sum | string sub -e 40)
        else if command -q shasum
            set path_hash (echo -n "$yaml_path" | shasum | string sub -e 40)
        end

        if test -n "$path_hash"
            set -l workspace_file "$HOME/.pulumi/workspaces/$project_name-$path_hash-workspace.json"

            if test -e $workspace_file
                set -l stack (string match -rg '[\'|"]stack[\'|"]:[ ]{0,1}[\'|"]([^"\']+)[\'|"]' < $workspace_file)

                _tide_print_item pulumi $tide_pulumi_icon' ' (echo $stack)
            end
        end
    end
end
