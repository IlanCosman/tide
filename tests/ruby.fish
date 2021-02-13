# RUN: %fish %s

function _ruby
    _tide_decolor (_tide_item_ruby)
end

set -l rubyDir ~/rubyTest
mkdir -p $rubyDir
cd $rubyDir

mock ruby --version "echo ruby 2.6.3p62"
set -lx tide_ruby_verbose_version true
set -lx tide_ruby_icon 

touch file.rb
_ruby # CHECK:  2.6.3p62
rm file.rb

_ruby # CHECK:

touch .ruby-version
set -lx tide_ruby_verbose_version false
_ruby # CHECK:  2.6.3

rm -r $rubyDir
