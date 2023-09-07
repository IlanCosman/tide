# RUN: %fish %s
_tide_parent_dirs

function _ruby
    _tide_decolor (_tide_item_ruby)
end

set -l ruby_directory (mktemp -d)
cd $ruby_directory

mock ruby --version "echo 'ruby 3.2.0 (2022-12-25 revision a528908271) +YJIT [arm64-darwin22]'"

set -lx tide_ruby_icon 

_ruby # CHECK:

touch Gemfile
touch foo.rb

_ruby # CHECK:  3.2.0

command rm -r $ruby_directory
