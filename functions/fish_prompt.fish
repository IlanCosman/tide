function fish_prompt --description 'Created by tide configure'
    set -lx _tide_last_pipestatus $pipestatus
    set -lx _tide_last_status $status

    fish --command 'set -g _tide_subshell; set -U _tide_left_prompt_display (_tide_prompt)' &

    string unescape $_tide_left_prompt_display
end

function _tide_refresh_prompt --on-variable _tide_left_prompt_display --on-variable _tide_right_prompt_display
    commandline --function repaint
end