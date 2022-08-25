function _tide_item_pulumi
    if test -e Pulumi.yaml
        set -l project_name (grep name Pulumi.yaml | string split -f 2 ' ')
        set -l yaml_path (pwd)/Pulumi.yaml
        set -l path_hash (python -c "import hashlib; print(hashlib.sha1(b'$yaml_path').hexdigest())")
        set -l stack (cat ~/.pulumi/workspaces/$project_name-$path_hash-workspace.json | grep stack | string split -f 4 '"')

        _tide_print_item pulumi $tide_pulumi_icon' ' (echo $stack)
    end
end
