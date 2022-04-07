# RUN: %fish %s
# Only run this test on macOS:
# REQUIRES: test $(uname) = Darwin

_tide_decolor (_tide_detect_os) # CHECK:  D6D6D6 333333
