function lean_wizard
    if test $COLUMNS -lt 55 || test $LINES -lt 21
        echo "Terminal size too small; must be at least 55 x 21"
        return 1
    end

    set -g fishPrompt "$__fish_config_dir/functions/fish_prompt.fish"
    set -g tempPrompt "$__fish_config_dir/lean_theme/temp_prompt.fish"
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
    set -g fake_lean_prompt_connection " "
    set -g fake_lean_prompt_connection_color 6C6C6C
end

function _promptHeight
    _title "Prompt Height"

    _option 1 "One line"
    _displayPrompt prompt_height 1

    _option 2 "Two lines"
    _displayPrompt prompt_height 2

    _displayRestartAndQuit

    switch (lean_user_ask "Choice" 1/2/r/q)
        case 1
            set -g prompt_height 1
            _promptSpacing
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

    _option 1 "Disconnected"
    _displayPrompt fake_lean_prompt_connection " "

    _option 2 "Dotted"
    _displayPrompt fake_lean_prompt_connection "·"

    _option 3 "Solid"
    _displayPrompt fake_lean_prompt_connection "─"

    _displayRestartAndQuit

    switch (lean_user_ask "Choice" 1/2/3/r/q)
        case 1
            set -g fake_lean_prompt_connection " "
            _promptSpacing
        case 2
            set -g fake_lean_prompt_connection "·"
            _promptConnectionColor
        case 3
            set -g fake_lean_prompt_connection "─"
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

    _option 1 "Lightest"
    _displayPrompt fake_lean_prompt_connection_color 808080

    _option 2 "Light"
    _displayPrompt fake_lean_prompt_connection_color 6C6C6C

    _option 3 "Dark"
    _displayPrompt fake_lean_prompt_connection_color 585858

    _option 4 "Darkest"
    _displayPrompt fake_lean_prompt_connection_color 444444

    _displayRestartAndQuit

    switch (lean_user_ask "Choice" 1/2/3/4/r/q)
        case 1
            set -g fake_lean_prompt_connection_color 808080
            _promptSpacing
        case 2
            set -g fake_lean_prompt_connection_color 6C6C6C
            _promptSpacing
        case 3
            set -g fake_lean_prompt_connection_color 585858
            _promptSpacing
        case 4
            set -g fake_lean_prompt_connection_color 444444
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

    _option 1 "Compact"
    _displayPrompt newline false
    echo -ne "\r\033[1A"
    _displayPrompt newline false

    _option 2 "Sparse"
    _displayPrompt newline true
    echo -ne "\r\033[1A"
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

function _assemblePrompt --argument-names which
    set -g moduleDir "$__fish_config_dir/lean_theme/prompt_modules/$which""_prompt"

    if test $which = "fish"
        set -g promptDir "$__fish_config_dir/functions/fish_prompt.fish"
    else
        set -g promptDir "$__fish_config_dir/lean_theme/temp_prompt.fish"
    end

    echo -n >$promptDir

    _addMod 1_initial
    if test $newline = "true"
        _addMod 2_newline
    end
    _addMod "3_"$prompt_height"Line"
    _addMod 4_final
    if test $prompt_height -eq 1
        # breakpoint
        _addMod 5_rightPrompt
    else
        _addMod 5_rPromptNoColor
    end
end

function _addMod --argument-names file
    cat "$moduleDir/$file.fish" >>$promptDir
    printf "\n\n" >>$promptDir
end

function _title --argument-names title
    set -l midCols (math $columns/2)
    set -l midTitle (math (string length $title)/2)

    for i in (seq (math $midCols-$midTitle))
        echo -n " "
    end
    set_color -o
    echo $title
    set_color normal
end

function _option --argument-names number text
    set_color -o
    echo "($number) $text"
    set_color normal
end

function _displayPrompt --argument-names var_name var_value
    set -g $var_name $var_value
    _assemblePrompt fake
    source $promptDir
    
    fake_prompt
    echo
    echo
end

function _displayRestartAndQuit
    echo -e "(r)  Restart from the beginning\n"
    echo -e "(q)  Quit and do nothing\n"
end

function _quit
    source $fishPrompt
    clear
end

function _finish
    _assemblePrompt fish
    set -U lean_prompt_connection $fake_lean_prompt_connection
    set -U lean_prompt_connection_color $fake_lean_prompt_connection_color
    _quit
end