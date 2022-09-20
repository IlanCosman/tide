# RUN: %fish %s
_tide_parent_dirs

function _pulumi
    _tide_decolor (_tide_item_pulumi)
end

set -l tmpdir (mktemp -d)
cd $tmpdir

# Test #1: No Pulumi.yaml file
_pulumi # CHECK:

# Test #2: No workspace file
# Setting up sample Pulumi.yaml file
touch Pulumi.yaml
echo "name: pulumi-test" >Pulumi.yaml

# Setting up sample workspaces folder
mkdir -p .pulumi/workspaces/

# Calculating path hash for sample Pulumi file in $tmpdir
set -l mock_path_hash ''
if command -q sha1sum
    set mock_path_hash (echo -n "$tmpdir/Pulumi.yaml" | sha1sum | string sub -e 40)
else if command -q shasum
    set mock_path_hash (echo -n "$tmpdir/Pulumi.yaml" | shasum | string sub -e 40)
end

# Overriding $HOME to force use sample workspace file
HOME=$tmpdir _pulumi # CHECK:

# Test #3: Ideal path
# Setting up sample workspace file with 'dev' as current stack
echo "{\"stack\": \"dev\"}" >.pulumi/workspaces/pulumi-test-$mock_path_hash-workspace.json

# Overriding $HOME to force use sample workspace file
HOME=$tmpdir _pulumi # CHECK:  dev

command rm -r $tmpdir
