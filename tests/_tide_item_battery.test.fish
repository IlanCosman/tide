# RUN: %fish %s
source (status dirname)/../functions/_tide_parent_dirs.fish
source (status dirname)/../functions/_tide_print_item.fish
source (status dirname)/../functions/_tide_item_vbattery.fish
source (status dirname)/../functions/_tide_item_hbattery.fish

function _tide_decolor
    string replace --all -r '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$argv"
end

set -g _tide_side right
set -g _tide_pad ''
set -g tide_right_prompt_separator_diff_color ''
set -g tide_right_prompt_separator_same_color ''
set -g tide_right_prompt_prefix ''

_tide_parent_dirs

set -lx tide_battery_color_critical red
set -lx tide_battery_color_low yellow
set -lx tide_battery_critical_threshold 15
set -lx tide_battery_low_threshold 40
set -lx tide_battery_method ''

# ── vbattery ──────────────────────────────────────────────────────────────────

function _vbattery
    _tide_decolor (_tide_item_vbattery)
end

set -lx tide_vbattery_bg_color normal
set -lx tide_vbattery_color normal

function upower
    echo 'No battery found'
end
_vbattery # CHECK:

function upower
    echo 'percentage:   50'
    echo 'state:      discharging'
end
_vbattery # CHECK: 󰁾

function upower
    echo 'percentage:   20'
    echo 'state:      discharging'
end
_vbattery # CHECK: 󰁻

function upower
    echo 'percentage:   10'
    echo 'state:      discharging'
end
_vbattery # CHECK: 󰁺

function upower
    echo 'percentage:   50'
    echo 'state:      charging'
end
_vbattery # CHECK: 󰢝

function upower
    echo 'percentage:   100'
    echo 'state:      fully charged'
end
_vbattery # CHECK: 󰁹

function upower
    echo 'percentage:   100'
    echo 'state:      not charging'
end
_vbattery # CHECK: 󰁹

function upower
    echo 'percentage:   50'
    echo 'state:      unknown'
end
_vbattery # CHECK: 󰂑

set -lx tide_battery_method termux
function termux-battery-status
    echo '{"percentage": 75, "status": "CHARGING"}'
end
_vbattery # CHECK: 󰂊

# ── hbattery ──────────────────────────────────────────────────────────────────

set -lx tide_battery_method ''

function _hbattery
    _tide_decolor (_tide_item_hbattery)
end

set -lx tide_hbattery_bg_color normal
set -lx tide_hbattery_color normal

function upower
    echo 'No battery found'
end
_hbattery # CHECK:

function upower
    echo 'percentage:   10'
    echo 'state:      discharging'
end
_hbattery # CHECK: 

function upower
    echo 'percentage:   30'
    echo 'state:      discharging'
end
_hbattery # CHECK: 

function upower
    echo 'percentage:   60'
    echo 'state:      discharging'
end
_hbattery # CHECK: 

function upower
    echo 'percentage:   80'
    echo 'state:      charging'
end
_hbattery # CHECK:  󰉁

function upower
    echo 'percentage:   80'
    echo 'state:      discharging'
end
_hbattery # CHECK: 

function upower
    echo 'percentage:   100'
    echo 'state:      fully charged'
end
_hbattery # CHECK: 

function upower
    echo 'percentage:   100'
    echo 'state:      not charging'
end
_hbattery # CHECK: 
