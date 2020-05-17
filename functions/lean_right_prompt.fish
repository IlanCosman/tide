function lean_right_prompt
    set -l splitText (string split '\n' (_fetch_right_prompt_items))

    for thing in $splitText[1..-2]
        _print_at_end $thing
    end
    if test (count $splitText) -eq $lean_left_prompt_height
        set -g lean_right_prompt_fish $splitText[-1]
    else
        _print_at_end $splitText[-1]
        set -g lean_right_prompt_fish ''
    end

    _cursor_up (math $lean_left_prompt_height-1)
end

function fish_right_prompt
    echo $lean_right_prompt_fish
end

function _fetch_right_prompt_items
    echo -n ' '

    for item in lean_{$lean_right_prompt_items}
        set -l itemOutput (_$item)

        if test -n "$itemOutput"
            echo -n $itemOutput
        end

        set_color normal
    end
end

function _print_at_end -a text
    set -l startLocation (math $COLUMNS-(string length (lean_decolor $text)))
    _cursor_right $startLocation
    echo -n $text

    printf '\v'
    printf '\r'
end