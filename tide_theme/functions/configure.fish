function tide_configure
    if test $COLUMNS -lt 55 || test $LINES -lt 21
        printf '%s\n' 'Terminal size too small; must be at least 55 x 21'
        return 1
    end

    set -g fake_columns $COLUMNS
    if test $fake_columns -gt 100
        set -g fake_columns 100
    end
    set -g fake_lines $LINES

    for fn in $_tide_dir/configure/functions/*
        source "$fn"
    end
    for promptItem in $_tide_dir/configure/prompt_items/*
        source "$promptItem"
    end

    _begin
end

function _begin
    _set_defaults
    _next_choice 'show_time'
end

function _set_defaults
    if test $fake_lines -ge 26
        set -g fake_tide_newline true
    else
        set -g fake_tide_newline false
    end

    set -g fake_tide_left_prompt_items 'pwd' 'git_prompt' 'newline' 'prompt_char'
    set -g fake_tide_right_prompt_items 'cmd_duration' 'time'

    set -g fake_tide_time_format ''
    set -g fake_tide_time_color 5F8787
    set -g fake_tide_prompt_connection_icon ' '
    set -g fake_tide_prompt_connection_color 6C6C6C
end

function _next_choice -a nextChoice
    source "$_tide_dir/configure/choices/$nextChoice.fish"
    $nextChoice
end

function _menu -a question options
    set -l optionList (string split '/' $options)
    set -l bold (set_color -o)
    set -l norm (set_color normal)

    while true
        read -P $bold"$question [$options] "$norm input

        if contains $input $optionList
            printf '%s\n' $input
            break
        end
    end
end

function _title -a text
    clear
    set -l midCols (math -s0 $fake_columns/2)
    set -l midTitle (math -s0 (string length $text)/2)

    _cursor_right (math $midCols-$midTitle)
    set_color -o
    printf '%s\n' $text
    set_color normal
end

function _option -a symbol text
    set_color -o
    printf '%s\n' "($symbol) $text"
    set_color normal
end

function _display_prompt -a var_name var_value
    if test -n "$var_name"
        set -g $var_name $var_value
    end
    fake_prompt
    printf '\n\n'
end

function _display_restart_and_quit
    printf '(r)  Restart from the beginning \n\n'
    printf '(q)  Quit and do nothing \n\n'
end

function _quit --on-signal INT
    source "$__fish_config_dir/functions/fish_prompt.fish"
    source "$__fish_config_dir/functions/_tide_left_prompt.fish"
    source "$__fish_config_dir/functions/_tide_right_prompt.fish"
    clear
end