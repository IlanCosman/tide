function asciicast_ezgif_durations -a file
    set -l times (string match -rg "^\[([\d.]*)" <$file)

    set -l durations # Durations in hundredths of seconds

    set -l prev_time $times[1]
    for time in $times[2..]
        set -a durations (math --scale=0 "($time - $prev_time) * 100")
        set prev_time $time
    end

    set -l file_text (cat $file)
    for duration in $durations
        string replace -r "^\[[\d.]*" $duration $file_text[1]
        set -e file_text[1]
    end >$file
end
