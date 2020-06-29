function _cursor_up -a number
    string repeat --count $number --no-newline \e\[1A
end

function _cursor_right -a number
    string repeat --count $number --no-newline \e\[1C
end