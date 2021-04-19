function _tide_item_elixir
    if test -e mix.exs
        set -l elixirVersion (elixir -v | sed -n 's/Elixir //;s/compiled with Erlang\///p')

        set_color $tide_elixir_color
        printf '%s' $tide_elixir_icon ' ' $elixirVersion
    end
end
