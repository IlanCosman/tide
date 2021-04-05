function _tide_detect_os
    switch (uname | string lower)
        case darwin
            printf '%s' 
        case freebsd openbsd dragonfly
            printf '%s' 
        case linux
            _tide_detect_os_linux_cases /etc/os-release ID ||
                _tide_detect_os_linux_cases /etc/os-release ID_LIKE ||
                _tide_detect_os_linux_cases /etc/lsb-release DISTRIB_ID ||
                printf '%s' 
        case '*'
            printf '%s' '?'
    end
end

function _tide_detect_os_linux_cases -a file key
    test -e $file || return
    set -l splitFile (string split '=' <$file)
    set -l keyIndex (contains --index $key $splitFile) || return
    set -l value (string trim --chars='"' $splitFile[(math $keyIndex + 1)] | string lower)

    set -l distroIcons \
        alpine  \
        aosc  \
        arch  \
        centos  \
        coreos  \
        debian  \
        devuan  \
        elementary  \
        fedora  \
        gentoo  \
        mageia  \
        manjaro  \
        mint  \
        nixos  \
        opensuse  \
        raspbian  \
        sabayon  \
        slackware  \
        tumbleweed  \
        ubuntu 

    set -l distroIndex (contains --index $value $distroIcons) || return
    printf '%s' $distroIcons[(math $distroIndex + 1)]
end
