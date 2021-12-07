import sys

from colormath.color_conversions import convert_color
from colormath.color_diff import delta_e_cie2000
from colormath.color_objects import LabColor, sRGBColor

# Taken from the gnome terminal Tango theme on 12/7/2021
TANGO_COLORS = {
    "black": "2E3436",
    "blue": "3465A4",
    "brblack": "555753",
    "brblue": "729FCF",
    "brcyan": "34E2E2",
    "brgreen": "8AE234",
    "brmagenta": "AD7FA8",
    "brred": "EF2929",
    "brwhite": "EEEEEC",
    "bryellow": "FCE94F",
    "cyan": "06989A",
    "green": "4E9A06",
    "magenta": "75507B",
    "red": "CC0000",
    "white": "D3D7CF",
    "yellow": "C4A000",
}


def hex_to_lab(hex):
    rgb = sRGBColor.new_from_rgb_hex(hex)
    return convert_color(rgb, LabColor)


def closest_tango_color(hex):
    input_color = hex_to_lab(hex)

    min_delta_e = sys.maxsize
    closest_color_name = None

    for color_name, color_hex in TANGO_COLORS.items():
        delta_e = delta_e_cie2000(input_color, hex_to_lab(color_hex))
        if delta_e < min_delta_e:
            min_delta_e = delta_e
            closest_color_name = color_name

    return closest_color_name


def main():
    for color in sys.argv[1:]:
        closest_color = closest_tango_color(color)
        if closest_color == "black":
            print(f"{color} | {closest_color} | Remember the rules for black!")
        else:
            print(f"{color} | {closest_color}")


if __name__ == "__main__":
    main()
