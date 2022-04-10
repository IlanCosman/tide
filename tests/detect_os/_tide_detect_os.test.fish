# RUN: %fish %s

mock uname \* "echo Darwin"

_tide_detect_os
# CHECK: 
# CHECK: D6D6D6
# CHECK: 333333

function _detect_os_linux_cases -a file
    set -l dir (status dirname)
    _tide_detect_os_linux_cases $dir/$file ID ||
        _tide_detect_os_linux_cases $dir/$file ID_LIKE ||
        _tide_detect_os_linux_cases $dir/$file DISTRIB_ID
end

_detect_os_linux_cases endeavouros-etc-release
# CHECK: 
# CHECK: 1793D1
# CHECK: 4D4D4D

# This tests spaces, e.g "opensuse suse"
_detect_os_linux_cases opensuse-etc-release
# CHECK: 
# CHECK: 73BA25
# CHECK: 173f4f
