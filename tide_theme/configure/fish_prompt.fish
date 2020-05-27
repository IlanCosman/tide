# Created by tide configure
function fish_prompt --description 'Write out the prompt'
    set -g last_pipestatus $pipestatus
    set -g last_status $status

    set -g git_dir (git rev-parse --show-toplevel 2>/dev/null)

    if test "$tide_newline" = 'true'
        printf '%b' '\n'
    end

    set_color $tide_prompt_connection_color
    string repeat --count $COLUMNS --no-newline $tide_prompt_connection_icon
    set_color normal

    printf '%b' '\r'
    _tide_right_prompt

    printf '%b' '\r'
    _tide_left_prompt
end
