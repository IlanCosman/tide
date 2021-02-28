function _tide_item_chruby
    if test -n "$RUBY_VERSION"
        set_color $tide_chruby_color
        printf '%s' $tide_chruby_icon' ' $RUBY_VERSION
    end
end
