# RUN: %fish %s

function _ruby
    _tide_decolor (_tide_item_ruby)
end

set -l ruby_directory (mktemp -d)
cd $ruby_directory

mock ruby current "echo ruby 2.6.8p205 (2021-07-07 revision 67951) [universal.x86_64-darwin21]"
set -lx tide_ruby_icon 

_ruby # CHECK:

touch .ruby-version
_ruby # CHECK:  2.6.8p205

rm -r $ruby_directory
