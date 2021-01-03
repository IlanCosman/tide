function _tide_item_pwd
    set -l preMaxDirsSplitPwd (string replace $HOME '~' $PWD | string split '/')
    set -l splitPwd $preMaxDirsSplitPwd[(math --scale=0 -$tide_pwd_max_dirs)..-1]
    set -l pwd (string join '/' $splitPwd)

    set -l gitDir (git rev-parse --show-toplevel 2>/dev/null)

    # Compute anchorDirs
    contains 'first' $tide_pwd_anchors && if test -n "$splitPwd[1]"
        set -a anchorDirs $splitPwd[1]
    else
        set -a anchorDirs $splitPwd[2]
    end
    contains 'last' $tide_pwd_anchors && set -a anchorDirs $splitPwd[-1]
    contains 'git' $tide_pwd_anchors && set -a anchorDirs (string split -r -m1 '/' "$gitDir")[2]

    set -l colorDirs (set_color $tide_pwd_color_dirs || echo)
    set -l colorAnchors (set_color -o $tide_pwd_color_anchors || echo)
    set -l keepBackgroundColor (set_color normal -b $tide_pwd_bg_color || echo)
    set -l colorTruncatedDirs (set_color $tide_pwd_color_truncated_dirs || echo)

    set -g _tide_pwd_output $colorDirs$pwd

    # Prepend icons
    if not test -w $PWD
        set -p _tide_pwd_output $colorDirs$tide_pwd_unwritable_icon
    else if test $PWD = $HOME
        set -p _tide_pwd_output $colorDirs$tide_pwd_home_icon
    else
        set -p _tide_pwd_output $colorDirs$tide_pwd_dir_icon
    end

    set -l truncatedList $splitPwd '.'
    # Empty string will cause an issue for the while loop
    test -z "$splitPwd[1]" && set -e truncatedList[1]
    set -l pwdMaxLength (math $COLUMNS -$tide_pwd_truncate_margin)

    for dir in $splitPwd
        if contains $dir $anchorDirs
            set _tide_pwd_output (string replace $dir $colorAnchors$dir$keepBackgroundColor $_tide_pwd_output)
        else if test (string length $pwd) -gt $pwdMaxLength
            set -l dirTruncated $dir
            set -l truncationLength 1
            test (string length $dirTruncated) -gt $truncationLength && while contains $dirTruncated $truncatedList
                set dirTruncated (string sub -l $truncationLength $dir)
                set truncationLength (math $truncationLength+1)
            end
            set -a truncatedList $dirTruncated

            set pwd (string replace $dir $dirTruncated $pwd)
            set _tide_pwd_output (string replace $dir $colorTruncatedDirs$dirTruncated $_tide_pwd_output)
        end
    end

    string replace --all '/' $colorDirs'/' $_tide_pwd_output
end