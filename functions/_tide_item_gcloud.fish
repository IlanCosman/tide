function _tide_item_gcloud
    set -q CLOUDSDK_CONFIG || set -l CLOUDSDK_CONFIG ~/.config/gcloud
    path is $CLOUDSDK_CONFIG/active_config \
        && read -l config <$CLOUDSDK_CONFIG/active_config \
        && path is $CLOUDSDK_CONFIG/configurations/config_$config \
        && string match -rg '^\s*project\s*=\s*(.*)' <$CLOUDSDK_CONFIG/configurations/config_$config | read -l project \
        && _tide_print_item gcloud $tide_gcloud_icon' ' $project
end
