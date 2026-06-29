# RUN: %fish %s

set -gx _tide_git_stale_color (set_color brblack)
set -g _tide_prompt_stale
set -l prompt 'before '(set_color green)__tide_git_start(set_color red)'main'(set_color yellow)' +1'__tide_git_end(set_color blue)' after'
set -l stale_match '*'(set_color brblack)'main +1*'
set -l red_match '*'(set_color red)'main*'

_tide_decolor (_tide_decolor_stale_git $prompt) # CHECK: before main +1 after
_tide_decolor_stale_git $prompt | string match -q $stale_match && echo stale # CHECK: stale

set -e _tide_prompt_stale
_tide_decolor_stale_git $prompt | string match -q '*__tide_git_start*' || echo no-marker # CHECK: no-marker
_tide_decolor_stale_git $prompt | string match -q $red_match && echo fresh-color # CHECK: fresh-color

set -g _tide_prompt_stale
set -e _tide_git_stale_color
_tide_decolor_stale_git $prompt | string match -q $red_match && echo disabled-color # CHECK: disabled-color
