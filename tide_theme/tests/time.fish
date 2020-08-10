@mesg '---------time---------'

function _time -a format
    set -lx tide_time_format $format
    sudo date 092512002002 >/dev/null # My birthday!
    _tide_decolor (_tide_item_time)
end

# Changing the date can mess with things, so we remember the correct one
# and set it back afterwards. This test will still put your clock off by a few seconds though.
set -l actualTime (date +"%m%d%H%M%y")

@test 'No format' (_time '') -z
@test '24 Hour' (_time '%T') = "12:00:00"
@test '12 Hour' (_time '%r') = "12:00:00 PM"

sudo date $actualTime >/dev/null