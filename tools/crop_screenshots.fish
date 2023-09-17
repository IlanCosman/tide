function crop_screenshots
    mogrify \
        # Top
        -chop 0x38 \
        # Bottom
        -crop +0-46 +repage \
        # Sides
        -shave 44x0 \
        # Output
        -path out \
        *.png
end
