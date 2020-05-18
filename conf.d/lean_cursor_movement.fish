function _cursor_up -a number
    if test $number -gt 0
        printf '%b' '\033['"$number"'A'
    end
end

function _cursor_right -a number
    if test $number -gt 0
        printf '%b' '\033['"$number"'C'
    end
end