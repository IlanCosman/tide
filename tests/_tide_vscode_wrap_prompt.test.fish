# RUN: %fish %s

set -gx VSCODE_INJECTION 1

function __vsc_fish_prompt_start
    printf A
end

function __vsc_fish_prompt
    printf 'left\nright\n'
end

function __vsc_fish_cmd_start
    printf B
end

_tide_vscode_wrap_prompt
fish_prompt | od -An -t x1 | string replace -ra '\s+' ' ' | string trim
# CHECK: 41 6c 65 66 74 0a 72 69 67 68 74 42
