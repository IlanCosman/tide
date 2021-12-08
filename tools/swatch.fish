#!/usr/bin/env fish

set -l height_in_lines 2

set -l width_in_chars (math --scale=0 $height_in_lines x 2.5) # 2.5 = ratio

for arg in $argv
    for i in (seq $height_in_lines)
        set_color -b $arg
        string repeat --no-newline --count $width_in_chars ' '
        set_color normal
        echo
    end
end
