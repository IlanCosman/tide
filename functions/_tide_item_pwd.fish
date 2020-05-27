function _tide_item_pwd
    set -l pwd (string replace $HOME '~' $PWD)
    set -l colorPwd $pwd
    set -l splitPwd (string split '/' $pwd)
    set -l splitGitDir (string replace $HOME '~' $git_dir | string split '/')
    set -l maxLength (math $COLUMNS-$tide_pwd_truncate_margin)

    set -l colorTruncatedDirs (set_color $tide_pwd_color_truncated_dirs)
    set -l colorMidDirs (set_color $tide_pwd_color_mid_dirs)
    set -l colorEndDirs (set_color -o $tide_pwd_color_end_dirs)

    set -l anchors 1 (count $splitPwd) (count $splitGitDir)

    if not test -w $PWD
        set_color $tide_pwd_color_mid_dirs
        printf '%s' {$tide_pwd_unwritable_icon}' '
    end

    for dir in $splitPwd
        set -l index (contains -i $dir $splitPwd)

        if contains $index $anchors
            set colorPwd (string replace $dir "$colorEndDirs"$dir(set_color normal) $colorPwd)
        else
            if test (string length $pwd) -gt $maxLength
                set -l dirTruncated (string sub -l 1 $dir)
                if test $dirTruncated = '.'
                    set dirTruncated (string sub -l 2 $dir)
                end

                set pwd (string replace $dir $dirTruncated $pwd)

                set -l colorTruncatedDirs (set_color $tide_pwd_color_truncated_dirs)
                set -l colorMidDirs (set_color $tide_pwd_color_mid_dirs)
                set colorPwd (string replace $dir "$colorTruncatedDirs"$dirTruncated $colorPwd)
            end
        end
    end

    set colorPwd (string replace -a '/' "$colorMidDirs"'/' $colorPwd)
    printf '%s ' $colorPwd
end