function lean_right_prompt
    set -l splitText (string split '\n' (_fetch_right_prompt_items))
    for thing in $splitText[1..-2]
        _print_at_end $thing
    end
    if test (count $splitText) -eq $lean_left_prompt_height
        set -g fishRightPromptRun $splitText[-1]
    else
        _print_at_end $splitText[-1]
        set -g fishRightPromptRun ''
    end
    echo
end

function fish_right_prompt
    echo $fishRightPromptRun
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
    echo -ne '\033['$startLocation'C'
    echo $text
end