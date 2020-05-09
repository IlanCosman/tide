function bench -a command times
    set -l thingToRun

    for i in (seq $times)
        set -a thingToRun $command
    end

    eval (string join ';' $thingToRun) >>'/dev/null'

    math $CMD_DURATION/$times
end