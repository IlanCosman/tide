# RUN: %fish %s

function _gcloud
    _tide_decolor (_tide_item_gcloud)
end

set -lx tide_gcloud_icon 

mock gcloud \* "echo ERROR: \(gcloud.config.get-value\) Section [core] has no property [project]. >&2; false"
_gcloud # CHECK:

mock gcloud \* "printf project"
_gcloud # CHECK:  project
