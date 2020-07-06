function _tide_cursor_right -a number
    string repeat --count $number --no-newline \e\[1C
end