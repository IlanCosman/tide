function lean_wizard
    if test $COLUMNS -lt 55 || test $LINES -lt 21
        echo "Terminal size too small; must be at least 55 x 21"
        return 1
    end

    set -g leanTimerDurationSave $lean_timer_duration
    set -U lean_timer_duration 0
    set -g tempPrompt "$__fish_config_dir/lean_theme/temp_prompt.fish"
    set -g moduleDir "$__fish_config_dir/lean_theme/prompt_modules"
    set -g fishPrompt "$__fish_config_dir/functions/fish_prompt.fish"
    set -g columns $COLUMNS
    set -g lines $LINES

    _begin
end

function _begin
    clear
    _setDefaults
    _promptHeight
end

function _setDefaults
    set -g newline true
    set -g lean_prompt_connection " "
    set -g lean_prompt_connection_color 6C6C6C
end

function _promptHeight
    _title "Prompt Height"

    echo "(1)  One line"
    _displayPrompt prompt_height 1

    echo "(2)  Two lines"
    _displayPrompt prompt_height 2

    _displayRestartAndQuit

    switch (lean_user_ask "Choice" 1/2/r/q)
        case 1
            set -g prompt_height 1
            _finish
        case 2
            set -g prompt_height 2
            _promptConnection
        case r
            _begin
        case q
            _quit
    end
end

function _promptConnection
    clear
    _title "Prompt Connection"

    echo "(1)  Disconnected"
    _displayPrompt lean_prompt_connection " "

    echo "(2)  Dotted"
    _displayPrompt lean_prompt_connection "·"

    echo "(3)  Solid"
    _displayPrompt lean_prompt_connection "─"

    _displayRestartAndQuit

    switch (lean_user_ask "Choice" 1/2/3/r/q)
        case 1
            set -U lean_prompt_connection " "
            set -g lean_prompt_connection " "
            _promptSpacing
        case 2
            set -U lean_prompt_connection "·"
            set -g lean_prompt_connection "·"
            _promptConnectionColor
        case 3
            set -U lean_prompt_connection "─"
            set -g lean_prompt_connection "─"
            _promptConnectionColor
        case r
            _begin
        case q
            _quit
    end
end

function _promptConnectionColor
    clear
    _title "Connection Color"

    echo "(1) Lightest"
    _displayPrompt lean_prompt_connection_color 808080

    echo "(2) Light"
    _displayPrompt lean_prompt_connection_color 6C6C6C

    echo "(3) Dark"
    _displayPrompt lean_prompt_connection_color 585858

    echo "(4) Darkest"
    _displayPrompt lean_prompt_connection_color 444444

    _displayRestartAndQuit

    switch (lean_user_ask "Choice" 1/2/3/4/r/q)
        case 1
            set -U lean_prompt_connection_color 808080
            set -g lean_prompt_connection_color 808080
            _promptSpacing
        case 2
            set -U lean_prompt_connection_color 6C6C6C
            set -g lean_prompt_connection_color 6C6C6C
            _promptSpacing
        case 3
            set -U lean_prompt_connection_color 585858
            set -g lean_prompt_connection_color 585858
            _promptSpacing
        case 4
            set -U lean_prompt_connection_color 444444
            set -g lean_prompt_connection_color 444444
            _promptSpacing
        case r
            _begin
        case q
            _quit
    end
end

function _promptSpacing
    clear
    _title "Prompt Spacing"

    echo "(1) Compact"
    _displayPrompt newline false
    _displayPrompt newline false

    echo "(2) Sparse"
    _displayPrompt newline true
    _displayPrompt newline true

    _displayRestartAndQuit

    switch (lean_user_ask "Choice" 1/2/r/q)
        case 1
            set -g newline false
            _finish
        case 2
            set -g newline true
            _finish
        case r
            _begin
        case q
            _quit
    end
end

function _assemble_prompt
    echo -n >$tempPrompt

    _addMod 1_initial
    if test $newline = "true"
        _addMod 2_newline
    end
    _addMod "3_"$prompt_height"Line"
    _addMod 4_final
end

function _addMod --argument-names file
    cat "$moduleDir/$file" >>$tempPrompt
end

function _title --argument-names title
    set -l midCols (math $columns/2)
    set -l midTitle (math (string length $title)/2)

    for i in (seq (math $midCols-$midTitle))
        echo -n " "
    end
    echo $title
end

function _displayPrompt --argument-names var_name var_value
    set -g $var_name $var_value
    _assemble_prompt
    source $tempPrompt
    fish_prompt
    echo
    echo
end

function _displayRestartAndQuit
    echo -e "(r)  Restart from the beginning\n"
    echo -e "(q)  Quit and do nothing\n"
end

function _quit
    set -U lean_timer_duration $leanTimerDurationSave
    source $fishPrompt
    fish_prompt
    clear
end

function _finish
    set -U lean_timer_duration $leanTimerDurationSave
    _assemble_prompt
    cat $tempPrompt >$fishPrompt
    source $fishPrompt
    clear
end