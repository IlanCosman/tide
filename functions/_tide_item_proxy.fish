function _tide_item_proxy
    begin
        env | grep -i -q 'all_proxy=\|http_proxy=\|https_proxy='
    end && _tide_print_item proxy $tide_proxy_icon
end
