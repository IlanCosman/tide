function _tide_detect_os
    switch (uname)
        case Darwin
            set -g _tide_os_icon 
        case FreeBSD OpenBSD Dragonfly
            set -g _tide_os_icon 
        case Linux
            switch (head -n 1 /etc/os-release | string split '"' | string lower)[2]
                case alpine
                    set -g _tide_os_icon 
                case arch
                    set -g _tide_os_icon 
                case centos
                    set -g _tide_os_icon 
                case debian
                    set -g _tide_os_icon 
                case elementary
                    set -g _tide_os_icon 
                case fedora
                    set -g _tide_os_icon 
                case gentoo
                    set -g _tide_os_icon 
                case linuxmint
                    set -g _tide_os_icon 
                case manjaro
                    set -g _tide_os_icon 
                case nixos
                    set -g _tide_os_icon 
                case opensuse tumbleweed
                    set -g _tide_os_icon 
                case raspbian
                    set -g _tide_os_icon 
                case ubuntu
                    set -g _tide_os_icon 
                case '*'
                    set -g _tide_os_icon 
            end
        case '*'
            set -g _tide_os_icon '?'
    end
end