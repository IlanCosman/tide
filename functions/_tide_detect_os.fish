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
    set -l split_file (string split '=' <$file)
    set -l key_index (contains --index $key $split_file) || return
    set -l value (string trim --chars='"' $split_file[(math $key_index + 1)] | string lower)

    set -l distro_icons \
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

    set -l distro_index (contains --index $value $distro_icons) || return
    printf '%s' $distro_icons[(math $distro_index + 1)]
end
