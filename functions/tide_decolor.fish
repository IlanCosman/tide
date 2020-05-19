function tide_decolor -a text
    set text (string replace -a (set_color normal) '' "$text")
    set text (string replace -ar '\e\[[0-9;]*m' '' "$text")

    printf '%s' "$text"
end