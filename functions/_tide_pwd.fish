function _tide_pwd
    set -l truncatedPwd $_tide_pwd
    set -l colorDirs (set_color $tide_pwd_color_dirs)

    set -g _tide_pwd_output $colorDirs$_tide_pwd

    if not test -w $PWD
        set _tide_pwd_output $colorDirs{$tide_pwd_unwritable_icon}' ' $_tide_pwd_output
    end

    set -l truncatedList '.' $_tide_split_pwd

    for dir in $_tide_split_pwd
        if contains $dir $_tide_pwd_anchors
            set _tide_pwd_output (string replace $dir (set_color -o $tide_pwd_color_anchors)$dir(set_color normal -b $tide_pwd_bg_color) $_tide_pwd_output)
        else if test (string length $truncatedPwd) -gt $_tide_pwd_max_length
            set -l dirTruncated $dir
            set -l truncationLength 1
            while contains $dirTruncated $truncatedList
                set dirTruncated (string sub -l $truncationLength $dir)
                set truncationLength (math $truncationLength+1)
            end
            set -a truncatedList $dirTruncated

            set truncatedPwd (string replace $dir $dirTruncated $truncatedPwd)
            set _tide_pwd_output (string replace $dir (set_color $tide_pwd_color_truncated_dirs)$dirTruncated $_tide_pwd_output)
        end
    end

    set _tide_pwd_output (string replace --all '/' $colorDirs'/' $_tide_pwd_output)
end