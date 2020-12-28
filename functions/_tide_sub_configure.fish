function _tide_sub_configure
    if test $COLUMNS -lt 55 -o $LINES -lt 21
        printf '%s\n' 'Terminal size too small; must be at least 55 x 21'
        return 1
    end

    set -g fake_columns $COLUMNS
    test $fake_columns -gt 90 && set fake_columns 90
    set -g fake_lines $LINES

    # Create an empty fake function for each item
    for func in _fake(functions --all | string match --entire _tide_item)
        function $func
        end
    end

    for file in $_tide_dir/configure/{functions, prompt_items}/*
        source "$file"
    end

    _next_choice 'all/style'
end

function _next_choice -a nextChoice
    source "$_tide_dir/configure/choices/$nextChoice.fish"
    set -l cmd (string split '/' $nextChoice)[2]
    $cmd
end

function _tide_title -a text
    set -l midCols (math --scale=0 $fake_columns/2)
    set -l midTitle (math --scale=0 (string length $text)/2)

    clear

    _tide_cursor_right (math $midCols-$midTitle)
    set_color -o
    printf '%s\n' $text
    set_color normal
end

function _tide_option -a symbol text
    set -ga _tide_option_list $symbol

    set_color -o
    printf '%s\n' "($symbol) $text"
    set_color normal
end

function _tide_menu
    set -l listWithSlashes (string join '/' $_tide_option_list)

    printf '%s\n' \
        '(r)  Restart from the beginning' \
        '(q)  Quit and do nothing'\n\n

    while true
        set -e _tide_selected_option

        _tide_cursor_up 1

        set_color -o
        read --prompt-str "Choice [$listWithSlashes/r/q] " input
        set_color normal

        switch $input
            case r
                set -e _tide_option_list
                _next_choice 'all/style'
                break
            case q
                clear
                break
            case $_tide_option_list
                set -e _tide_option_list
                set -g _tide_selected_option $input
                break
        end
    end
end

function _tide_display_prompt -a var_name var_value
    test -n "$var_name" && set -g $var_name $var_value
    fake_prompt
    printf '\n\n'
end

function _find_and_remove -a name list --no-scope-shadowing
    set -e "$list"[(contains --index $name $$list)] 2>/dev/null # Ignore error if $list doesn't contain $name
end