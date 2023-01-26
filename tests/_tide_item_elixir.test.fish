# RUN: %fish %s
_tide_parent_dirs

function _elixir
    _tide_decolor (_tide_item_elixir)
end

set -l elixirDir (mktemp -d)
cd $elixirDir

mock elixir --short-version "echo 1.14.1"
set -lx tide_elixir_icon 

_elixir # CHECK:

touch mix.exs
_elixir # CHECK:  1.14.1

command rm -r $elixirDir
