@mesg '---------cursor_right---------'

set -lx text 'hello'

@test 'Move cursor' (string escape (_tide_cursor_right 5 && echo $text)) = "\e\[1C\e\[1C\e\[1C\e\[1C\e\[1C$text"