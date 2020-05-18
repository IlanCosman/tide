function lean_right_prompt
    set -l splitText (string split '\n' (_fetch_right_prompt_items))
    set -l printAtEndedRightPromptHeight (count $splitText)

    for thing in $splitText[1..-2]
        _print_at_end $thing
    end
    if test $printAtEndedRightPromptHeight -eq $lean_left_prompt_height
        set -g lean_right_prompt_fish $splitText[-1]
        set printAtEndedRightPromptHeight (math $printAtEndedRightPromptHeight-1)
    else
        _print_at_end $splitText[-1]
        set -g lean_right_prompt_fish ''
    end

    _cursor_up $printAtEndedRightPromptHeight
end

function fish_right_prompt
    printf '%s' $lean_right_prompt_fish
end

function _fetch_right_prompt_items
    printf '%s' ' '

    for item in lean_{$lean_right_prompt_items}
        set -l itemOutput (_$item)
        printf '%s' "$itemOutput"

        set_color normal
    end
end

function _print_at_end -a text
    set -l startLocation (math $COLUMNS -(string length (lean_decolor $text)))
    _cursor_right $startLocation
    printf '%s' $text

    printf '%b' '\v'
    printf '%b' '\r'
end