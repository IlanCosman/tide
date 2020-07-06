function _tide_cursor_up -a number
    string repeat --count $number --no-newline \e\[1A
end