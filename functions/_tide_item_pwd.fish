function _tide_item_pwd
    set -l pwd (string replace $HOME '~' $PWD)
    set -l colorPwd $pwd
    set -l splitPwd (string split --no-empty '/' $pwd)
    set -l maxLength (math $COLUMNS-$tide_pwd_truncate_margin)

    set -l dirColor (set_color $tide_pwd_color_dirs)
    set -l truncatedDirColor (set_color $tide_pwd_color_truncated_dirs)
    set -l anchorColor (set_color -o $tide_pwd_color_anchors)

    set -l anchors (_parse_anchors $splitPwd)

    if not test -w $PWD
        set_color $tide_pwd_color_dirs
        printf '%s' {$tide_pwd_unwritable_icon}' '
    end

    for dir in $splitPwd
        set -l index (contains -i $dir $splitPwd)
        if contains $index $anchors
            set colorPwd (string replace $dir "$anchorColor"$dir(set_color normal) $colorPwd)
        else
            if test (string length $pwd) -gt $maxLength
                set -l dirTruncated (string sub -l 1 $dir)
                if test $dirTruncated = '.'
                    set dirTruncated (string sub -l 2 $dir)
                end

                set pwd (string replace $dir $dirTruncated $pwd)
                set colorPwd (string replace $dir "$truncatedDirColor"$dirTruncated $colorPwd)
            end
        end
    end

    set colorPwd $dirColor$colorPwd
    set colorPwd (string replace -a '/' "$dirColor"'/' $colorPwd)
    printf '%s ' $colorPwd
end

function _parse_anchors
    set -l splitGitDir (string replace $HOME '~' $git_dir | string split --no-empty '/')

    set -l anchors
    if contains 'first' $tide_pwd_anchors
        set -a anchors 1
    end
    if contains 'last' $tide_pwd_anchors
        set -a anchors (count $argv)
    end
    if contains 'git' $tide_pwd_anchors
        set -a anchors (count $splitGitDir)
    end
    printf '%s\n' $anchors
end