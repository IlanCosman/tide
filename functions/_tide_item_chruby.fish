function _tide_item_chruby
    test -n "$RUBY_VERSION" && _tide_print_item ruby $RUBY_VERSION
end
