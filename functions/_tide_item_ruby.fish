function _tide_item_ruby
    if path is $_tide_parent_dirs/Gemfile || path is $_tide_parent_dirs/Rakefile || path is $_tide_parent_dirs/*.gemspec || path is $_tide_parent_dirs/.ruby-version || path is $_tide_parent_dirs/.tool-versions
        _tide_print_item ruby $tide_ruby_icon' ' (ruby --version | string split ' ')[2]''
    end
end
