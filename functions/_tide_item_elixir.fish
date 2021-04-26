function _tide_item_elixir
    if test -e mix.exs
        set -l elixirVersion (elixir -v | string replace -r 'Elixir ([0-9]+\.[0-9]+\.[0-9]+) \(compiled with Erlang\/(OTP [0-9]+)\)' '$1 \($2\)' | tail -1)

        set_color $tide_elixir_color
        printf '%s' $tide_elixir_icon ' ' $elixirVersion
    end
end
