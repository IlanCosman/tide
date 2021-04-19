# RUN: %fish %s

function _elixir
    _tide_decolor (_tide_item_elixir)
end

set -l elixirDir ~/elixirDir
mkdir -p $elixirDir
cd $elixirDir

mock elixir -v "echo 'Elixir 1.10.4 (compiled with Erlang/OTP 23)'"
set -lx tide_elixir_icon 

_elixir # CHECK: 

touch mix.exs
_elixir # CHECK:  1.10.4 (OTP 23)

rm -r $elixirDir
