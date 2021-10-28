function _tide_item_gcloud
    set -l project (gcloud config get-value core/project 2>/dev/null) &&
        _tide_print_item gcloud $tide_gcloud_icon' ' $project
end
