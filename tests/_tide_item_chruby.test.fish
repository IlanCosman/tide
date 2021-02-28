# RUN: %fish %s

function _chruby
    _tide_decolor (_tide_item_chruby)
end

set -lx RUBY_VERSION

_chruby # CHECK:

set -lx RUBY_VERSION 3.0.0
set -lx tide_chruby_icon 

_chruby # CHECK:  3.0.0
