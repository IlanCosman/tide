# RUN: %fish %s
_tide_parent_dirs

function _gcloud
    _tide_decolor (_tide_item_gcloud)
end

set -lx tide_gcloud_icon G
set -l tmpdir (mktemp -d)
cd $tmpdir
set -lx HOME $tmpdir

_gcloud # CHECK:

mkdir -p $tmpdir/.config/gcloud
echo default >$tmpdir/.config/gcloud/active_config
_gcloud # CHECK:

mkdir -p $tmpdir/.config/gcloud/configurations
echo "project = test" >$tmpdir/.config/gcloud/configurations/config_default
_gcloud # CHECK: G test

command rm -r $tmpdir
