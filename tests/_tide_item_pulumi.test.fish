# RUN: %fish %s

function _pulumi
    _tide_decolor (_tide_item_pulumi)
end

set -l tmpdir (mktemp -d)
cd $tmpdir

# No Pulumi.yaml file
_pulumi # CHECK:

# Pulumi.yaml file with sample project name
touch Pulumi.yaml
echo "name: pulumi-test" >Pulumi.yaml

# Mock contents of workspace json with sample stack
mock cat \* "echo '{\"stack\": \"dev\"}'"

_pulumi # CHECK:  dev

/bin/rm -r $tmpdir
