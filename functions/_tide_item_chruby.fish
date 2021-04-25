function _tide_item_chruby
    test -n "$RUBY_VERSION" && _tide_print_item chruby $RUBY_VERSION
end
