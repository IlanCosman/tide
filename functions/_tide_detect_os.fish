function _tide_detect_os
    switch (uname | string lower)
        case darwin
            echo -ns 
        case freebsd openbsd dragonfly
            echo -ns 
        case linux
            _tide_detect_os_linux_cases /etc/os-release ID ||
                _tide_detect_os_linux_cases /etc/os-release ID_LIKE ||
                _tide_detect_os_linux_cases /etc/lsb-release DISTRIB_ID ||
                echo -ns 
        case '*'
            echo -ns '?'
    end
end

function _tide_detect_os_linux_cases -a file key
    test -e $file || return
    set -l split_file (string split '=' <$file)
    set -l key_index (contains --index $key $split_file) || return
    set -l value (string trim --chars='"' $split_file[(math $key_index + 1)] | string lower)

    # Name, icon, color, bg_color, source
    set -l distro_data \
        alpine  FFFFFF 0D597F "from alpine logo" \
        arch  1793D1 4D4D4D "from arch wiki header" \
        centos  000000 FFFFFF "https://wiki.centos.org/ArtWork/Brand/Logo, monochromatic" \
        debian  C70036 FFFFFF "from debian logo https://www.debian.org/logos/openlogo-nd-100.png" \
        devuan  080808 CED7CF default \
        elementary  000000 FFFFFF "https://elementary.io/brand, encouraged to be monochromatic" \
        fedora  FFFFFF 294172 "from logo https://fedoraproject.org/w/uploads/2/2d/Logo_fedoralogo.png" \
        gentoo  FFFFFF 54487A "https://wiki.gentoo.org/wiki/Project:Artwork/Colors" \
        mageia  FFFFFF 262F45 "https://wiki.mageia.org/en/Artwork_guidelines" \
        manjaro  FFFFFF 35BF5C "from https://gitlab.manjaro.org/artwork/branding/logo/-/blob/master/logo.svg" \
        mint  FFFFFF 69B53F "extracted from https://linuxmint.com/web/img/favicon.ico" \
        nixos  FFFFFF 5277C3 "https://github.com/NixOS/nixos-artwork/tree/master/logo" \
        opensuse  73BA25 173f4f "https://en.opensuse.org/openSUSE:Artwork_brand" \
        raspbian  FFFFFF A22846 "https://static.raspberrypi.org/files/Raspberry_Pi_Visual_Guidelines_2020.pdf" \
        sabayon  080808 CED7CF default \
        slackware  080808 CED7CF default \
        tumbleweed  73BA25 173f4f "https://en.opensuse.org/openSUSE:Artwork_brand" \
        ubuntu  E95420 FFFFFF "https://design.ubuntu.com/brand/"

    set -l distro_index (contains --index $value $distro_data) || return
    echo -ns $distro_data[(math $distro_index + 1)]
end
