function _tide_item_pi_temp
  if type -q vcgencmd
    vcgencmd measure_temp | string match -qr "(?<t>[\d.]+)"
    _tide_print_item pi_temp $t' ' $tide_pi_temp_icon
  end
end
