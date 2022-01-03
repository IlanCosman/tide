function _tide_item_ruby
    if test -e .ruby-version
        _tide_print_item ruby $tide_ruby_icon' ' (ruby --version | string split ' ')[2]
    end
end
