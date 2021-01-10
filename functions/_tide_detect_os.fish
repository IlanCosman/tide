function _tide_detect_os
    switch (uname | string lower)
        case darwin
            set -gx _tide_os_icon 
        case freebsd openbsd dragonfly
            set -gx _tide_os_icon 
        case linux
            _tide_detect_os_linux_cases /etc/os-release ID ||
            _tide_detect_os_linux_cases /etc/os-release ID_LIKE ||
            _tide_detect_os_linux_cases /etc/lsb-release DISTRIB_ID ||
            set -gx _tide_os_icon 
        case '*'
            set -gx _tide_os_icon '?'
    end
end

function _tide_detect_os_linux_cases -a file key
    test -f $file || return

    set -l splitOsRelease (cat $file | string split '=')
    set -l keyIndex (contains --index $key $splitOsRelease) || return
    set -l value $splitOsRelease[(math $keyIndex + 1)]
    set -l name (string trim --chars='"' $value | string lower)

    switch $name
        case alpine
            set -gx _tide_os_icon 
        case arch
            set -gx _tide_os_icon 
        case centos
            set -gx _tide_os_icon 
        case debian
            set -gx _tide_os_icon 
        case elementary
            set -gx _tide_os_icon 
        case fedora
            set -gx _tide_os_icon 
        case gentoo
            set -gx _tide_os_icon 
        case linuxmint
            set -gx _tide_os_icon 
        case manjaro
            set -gx _tide_os_icon 
        case nixos
            set -gx _tide_os_icon 
        case opensuse tumbleweed
            set -gx _tide_os_icon 
        case raspbian
            set -gx _tide_os_icon 
        case ubuntu
            set -gx _tide_os_icon 
        case '*'
            return 1
    end
    return 0 # If we didn't run into the catch case '*' return succesfull
end
