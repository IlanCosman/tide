function _tide_item_elixir
    mix deps >/dev/null 2>/dev/null

    if test $status = 0
        set -l elixirVersion (elixir -v | sed -n 's/Elixir //p;s/compiled with Erlang\///p')

        set_color $tide_elixir_color
        printf '%s' $tide_elixir_icon ' ' $elixirVersion
    end
end
