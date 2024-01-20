function _tide_item_pi_temp
    if type -q vcgencmd
        vcgencmd measure_temp | string match -qr "(?<t>[\d.]+)"
        if test $t -ge 80
            set -fx tide_pi_temp_color $tide_pi_temp_hi_color
        else
            if test $t -ge 70
                set -fx tide_pi_temp_color $tide_pi_temp_mid_color
            else
                set -fx tide_pi_temp_color $tide_pi_temp_lo_color
            end
        end
        _tide_print_item pi_temp $t' ' $tide_pi_temp_icon
    end
end
