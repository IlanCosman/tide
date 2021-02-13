function _tide_item_ruby
    if command --quiet ruby && test -e .ruby-version -o (count *.rb) -gt 0
        set_color $tide_ruby_color

        if test "$tide_ruby_verbose_version" = false
            # Cut off -patch_version. "3.0.0p0" vs "3.0.0"
            printf '%s' $tide_ruby_icon' ' (ruby --version | string split ' ' | string split 'p')[2]
        else
            printf '%s' $tide_ruby_icon' ' (ruby --version | string split ' ')[2]
        end
    end
end
