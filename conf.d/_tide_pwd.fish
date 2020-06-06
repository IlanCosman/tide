function _tide_pwd
    set -l truncatedPwd $_tide_pwd
    set -g display_pwd $_tide_pwd

    if not test -w $PWD
        set display_pwd $dirColor{$tide_pwd_unwritable_icon}' '$display_pwd
    end

    for dir in $_tide_split_pwd
        set -l index (contains -i $dir $_tide_split_pwd)
        if contains $index $anchors
            set display_pwd (string replace $dir "$anchorColor"$dir(set_color normal) $display_pwd)
        else
            if test (string length $truncatedPwd) -gt $max_length
                set -l dirTruncated (string sub -l 1 $dir)
                if test $dirTruncated = '.'
                    set dirTruncated (string sub -l 2 $dir)
                end

                set truncatedPwd (string replace $dir $dirTruncated $truncatedPwd)
                set display_pwd (string replace $dir "$truncatedDirColor"$dirTruncated $display_pwd)
            end
        end
    end

    set display_pwd (string replace -a '/' "$dirColor"'/' $display_pwd)
end