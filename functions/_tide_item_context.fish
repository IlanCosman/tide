function _tide_item_context
    set -l displayedHost $hostname

    if test "$tide_short_hostname" = 'true'
        # note: might break for IPs
        # TODO: regex for IPv4/IPv6
        set displayedHost (string join '.' (string split '.' $displayedHost)[1..-3])
    end

    if set -q SSH_TTY
        set_color $tide_context_ssh_color
        printf '%s' $USER'@'$displayedHost
    else if test $USER = 'root'
        set_color $tide_context_root_color
        printf '%s' $USER'@'$displayedHost
    else if test "$tide_context_always_display" = 'true'
        set_color $tide_context_default_color
        printf '%s' $USER'@'$displayedHost
    end
end