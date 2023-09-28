function crop_screenshots
    mogrify \
        # Top
        -chop 0x43 \
        # Bottom
        -crop +0-54 +repage \
        # Sides
        -shave 49x0 \
        # Output
        -path out \
        *.png
end
