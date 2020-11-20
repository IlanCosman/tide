function fish_prompt --description 'Created by tide configure'
    set -lx _tide_last_pipestatus $pipestatus
    set -lx _tide_last_status $status

    fish --command 'set -U _tide_prompt (_tide_prompt)' &

    printf '%s\n' $_tide_prompt
end

function _tide_prompt --on-variable _tide_prompt
    commandline --function repaint
end