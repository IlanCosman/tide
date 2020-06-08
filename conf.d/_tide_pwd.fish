function _tide_pwd
    set -l truncatedPwd $_tide_pwd
    set -g _tide_pwd_output $_tide_pwd

    if not test -w $PWD
        set -p _tide_pwd_output (set_color $tide_pwd_color_dirs){$tide_pwd_unwritable_icon}
    end

    set -l truncatedList '.' $_tide_split_pwd

    for dir in $_tide_split_pwd
        if contains $dir $_tide_pwd_anchors
            set _tide_pwd_output (string replace $dir (set_color -o $tide_pwd_color_anchors)$dir$_tide_color_normal $_tide_pwd_output)
        else
            if test (string length $truncatedPwd) -gt $_tide_pwd_max_length
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
    end

    set _tide_pwd_output (string replace -a '/' (set_color $tide_pwd_color_dirs)'/' $_tide_pwd_output)
end