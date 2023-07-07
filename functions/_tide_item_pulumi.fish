function _tide_item_pulumi
    if path filter $_tide_parent_dirs/Pulumi.yaml | read -l yaml_path
        if command -q sha1sum
            echo -n "$yaml_path" | sha1sum | string match -qr "(?<path_hash>.{40})"
        else if command -q shasum
            echo -n "$yaml_path" | shasum | string match -qr "(?<path_hash>.{40})"
        else
            return
        end

        string match -qr 'name: *(?<project_name>.*)' <$yaml_path
        set -l workspace_file "$HOME/.pulumi/workspaces/$project_name-$path_hash-workspace.json"

        if test -e $workspace_file
            string match -qr '"stack": *"(?<stack>.*)"' <$workspace_file
            _tide_print_item pulumi $tide_pulumi_icon' ' $stack
        end
    end
end
