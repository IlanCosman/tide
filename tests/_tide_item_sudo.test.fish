# RUN: %fish %s
_tide_parent_dirs

mock sudo \* "return 1"
_tide_decolor (_tide_item_sudo) # CHECK:

mock sudo \* "return 0"
set -g tide_sudo_icon 󰌋
_tide_decolor (_tide_item_sudo) # CHECK: 󰌋
