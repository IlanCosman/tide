function lean_right_prompt
    echo -n ' '

    for item in lean_{$lean_right_prompt_items}
        if test -n "$$item"
            set -l colorName $item'_color'
            set -l colorNameBoldFlag $colorName'_bold'

            if test $colorNameBoldFlag = 'true'
                set_color -o
            end
            set_color "$$colorName"
            echo -n "$$item"' '
            set_color normal
        end
    end
end