function _tide_pwd --on-variable PWD --on-signal WINCH
    set -l preMaxDirsSplitPwd (string replace $HOME '~' $PWD | string split '/')
    set -l splitPwd $preMaxDirsSplitPwd[(math --scale=0 -$tide_pwd_max_dirs)..-1]
    set -l pwd (string join '/' $splitPwd)

    set -g _tide_git_dir (git rev-parse --show-toplevel 2>/dev/null) # Used for git_prompt item

    # Compute anchors
    if contains 'first' $tide_pwd_anchors
        if test -n "$splitPwd[1]"
            set -a tidePwdAnchors $splitPwd[1]
        else
            set -a tidePwdAnchors $splitPwd[2]
        end
    end
    if contains 'last' $tide_pwd_anchors
        set -a tidePwdAnchors $splitPwd[-1]
    end
    if contains 'git' $tide_pwd_anchors
        set -a tidePwdAnchors (string split -r -m1 '/' "$_tide_git_dir")[2]
    end

    set -l colorDirs (set_color $tide_pwd_color_dirs; or echo)
    set -l colorAnchors (set_color -o $tide_pwd_color_anchors; or echo)
    set -l keepBackgroundColor (set_color normal -b $tide_pwd_bg_color; or echo)
    set -l colorTruncatedDirs (set_color $tide_pwd_color_truncated_dirs; or echo)

    set -g _tide_pwd_output $colorDirs$pwd

    # Prepend icons
    if not test -w $PWD
        set -p _tide_pwd_output $colorDirs$tide_pwd_unwritable_icon' '
    else if test $PWD = $HOME
        set -p _tide_pwd_output $colorDirs$tide_pwd_home_icon' '
    else
        set -p _tide_pwd_output $colorDirs$tide_pwd_dir_icon' '
    end

    set -l truncatedList $splitPwd '.'
    if test -z "$splitPwd[1]" # Empty string will cause an issue for the while loop
        set -e truncatedList[1]
    end
    set -l pwdMaxLength (math $COLUMNS -$tide_pwd_truncate_margin)

    for dir in $splitPwd
        if contains $dir $tidePwdAnchors
            set _tide_pwd_output (string replace $dir $colorAnchors$dir$keepBackgroundColor $_tide_pwd_output)
        else if test (string length $pwd) -gt $pwdMaxLength
            set -l dirTruncated $dir
            set -l truncationLength 1
            while contains $dirTruncated $truncatedList
                set dirTruncated (string sub -l $truncationLength $dir)
                set truncationLength (math $truncationLength+1)
            end
            set -a truncatedList $dirTruncated

            set pwd (string replace $dir $dirTruncated $pwd)
            set _tide_pwd_output (string replace $dir $colorTruncatedDirs$dirTruncated $_tide_pwd_output)
        end
    end

    set _tide_pwd_output (string replace --all '/' $colorDirs'/' $_tide_pwd_output)
end