# RUN: %fish %s
_tide_parent_dirs

set -lx tide_proxy_icon 䀹

set -lx HTTP_PROXY http://127.0.0.1:7890
_tide_decolor (_tide_item_proxy) # CHECK: 䀹
set -e HTTP_PROXY

set -lx all_proxy http://127.0.0.1:7890
_tide_decolor (_tide_item_proxy) # CHECK: 䀹
set -e all_proxy

_tide_decolor (_tide_item_jobs) # CHECK:
