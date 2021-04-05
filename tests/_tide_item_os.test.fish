# RUN: %fish %s
# Only run this test on macOS:
# REQUIRES: test $(uname) = Darwin

_tide_decolor (_tide_item_os) # CHECK: 
