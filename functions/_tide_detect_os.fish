# Outputs icon, color, bg_color
function _tide_detect_os
    set -lx defaultColor 080808 CED7CF
    switch (uname | string lower)
        case darwin
            printf %s\n  D6D6D6 333333 # from apple.com header
        case freebsd openbsd dragonfly
            printf %s\n  FFFFFF AB2B28 # https://freebsdfoundation.org/about-us/about-the-foundation/project/
        case 'cygwin*' 'mingw*_nt*' 'msys_nt*'
            printf %s\n  FFFFFF 00CCFF # https://answers.microsoft.com/en-us/windows/forum/all/what-is-the-official-windows-8-blue-rgb-or-hex/fd57144b-f69b-42d8-8c21-6ca911646e44
        case linux
            if test (uname -o) = Android
                # https://developer.android.com/distribute/marketing-tools/brand-guidelines
                printf %s\n  3DDC84 3C3F41 # fg is from above link, bg is from Android Studio default dark theme
            else
                _tide_detect_os_linux_cases /etc/os-release ID ||
                    _tide_detect_os_linux_cases /etc/os-release ID_LIKE ||
                    _tide_detect_os_linux_cases /etc/lsb-release DISTRIB_ID ||
                    printf %s\n  $defaultColor
            end
        case '*'
            echo -ns '?'
    end
end

function _tide_detect_os_linux_cases -a file key
    test -e $file || return
    set -l split_file (string split '=' <$file)
    set -l key_index (contains --index $key $split_file) || return
    set -l value (string trim --chars='"' $split_file[(math $key_index + 1)])

    # Anything which would have pure white background has been changed to D4D4D4
    # It was just too bright otherwise
    switch (string lower $value)
        case alpine
            printf %s\n  FFFFFF 0D597F # from alpine logo
        case arch
            printf %s\n  1793D1 4D4D4D # from arch wiki header
        case centos
            printf %s\n  000000 D4D4D4 # https://wiki.centos.org/ArtWork/Brand/Logo, monochromatic
        case debian
            printf %s\n  C70036 D4D4D4 # from debian logo https://www.debian.org/logos/openlogo-nd-100.png
        case devuan
            printf %s\n  $defaultColor # logo is monochromatic
        case elementary
            printf %s\n  000000 D4D4D4 # https://elementary.io/brand, encouraged to be monochromatic
        case fedora
            printf %s\n  FFFFFF 294172 # from logo https://fedoraproject.org/w/uploads/2/2d/Logo_fedoralogo.png
        case gentoo
            printf %s\n  FFFFFF 54487A # https://wiki.gentoo.org/wiki/Project:Artwork/Colors
        case mageia
            printf %s\n  FFFFFF 262F45 # https://wiki.mageia.org/en/Artwork_guidelines
        case manjaro
            printf %s\n  FFFFFF 35BF5C # from https://gitlab.manjaro.org/artwork/branding/logo/-/blob/master/logo.svg
        case mint linuxmint
            printf %s\n  FFFFFF 69B53F # extracted from https://linuxmint.com/web/img/favicon.ico
        case nixos
            printf %s\n  FFFFFF 5277C3 # https://github.com/NixOS/nixos-artwork/tree/master/logo
        case opensuse-leap opensuse-tumbleweed opensuse-microos
            printf %s\n  73BA25 173f4f # https://en.opensuse.org/openSUSE:Artwork_brand
        case raspbian
            printf %s\n  FFFFFF A22846 # https://static.raspberrypi.org/files/Raspberry_Pi_Visual_Guidelines_2020.pdf
        case rhel
            printf %s\n  EE0000 000000 # https://www.redhat.com/en/about/brand/standards/color
        case sabayon
            printf %s\n  $defaultColor # Can't find colors, and they are rebranding anyway
        case slackware
            printf %s\n  $defaultColor # Doesn't really have a logo, and the colors are too close to PWD blue anyway
        case ubuntu
            printf %s\n  E95420 D4D4D4 # https://design.ubuntu.com/brand/
        case void
            printf %s\n  FFFFFF 478061 # from https://alpha.de.repo.voidlinux.org/logos/void.svg
        case '*'
            return 1
    end
end
