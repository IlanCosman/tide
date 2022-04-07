# RUN: %fish %s
# Only run this test on macOS:
# REQUIRES: test $(uname) = Darwin

_tide_detect_os
# CHECK: 
# CHECK: D6D6D6
# CHECK: 333333
