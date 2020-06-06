function _tide_pwd
    set -l truncatedPwd $_tide_pwd
    set -g _tide_pwd_output $_tide_pwd

    if not test -w $PWD
        set _tide_pwd_output $_tide_pwd_dir_color{$tide_pwd_unwritable_icon}' '$_tide_pwd_output
    end

    for dir in $_tide_split_pwd
        set -l index (contains -i $dir $_tide_split_pwd)
        if contains $index $_tide_pwd_anchors
            set _tide_pwd_output (string replace $dir "$_tide_pwd_anchor_color"$dir(set_color normal) $_tide_pwd_output)
        else
            if test (string length $truncatedPwd) -gt $_tide_pwd_max_length
                set -l dirTruncated (string sub -l 1 $dir)
                if test $dirTruncated = '.'
                    set dirTruncated (string sub -l 2 $dir)
                end

                set truncatedPwd (string replace $dir $dirTruncated $truncatedPwd)
                set _tide_pwd_output (string replace $dir "$_tide_pwd_truncated_dir_color"$dirTruncated $_tide_pwd_output)
            end
        end
    end

    set _tide_pwd_output (string replace -a '/' "$_tide_pwd_dir_color"'/' $_tide_pwd_output)
end