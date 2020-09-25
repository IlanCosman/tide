@mesg '---------decolor---------'

set -lx decolorText 'Hello Foo'

function _decolor -a color
    _tide_decolor (set_color $color)$decolorText
end

@test 'Color' (_decolor red) = $decolorText
@test 'Normal' (_decolor normal) = $decolorText