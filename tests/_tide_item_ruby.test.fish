# RUN: %fish %s
_tide_parent_dirs

function _ruby
    _tide_decolor (_tide_item_ruby)
end

set -lx RUBY_VERSION

_ruby # CHECK:

set -lx RUBY_VERSION 3.0.0
set -lx tide_ruby_icon 

_ruby # CHECK:  3.0.0
