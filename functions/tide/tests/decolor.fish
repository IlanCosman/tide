# RUN: %fish %s

set -lx decolorText 'Hello Foo'

function _decolor -a color
    _tide_decolor (set_color $color || echo)'Hello Foo'
end

_decolor red # CHECK: Hello Foo
_decolor normal # CHECK: Hello Foo
