# RUN: %fish %s

function _rvm
    _tide_decolor (_tide_item_rvm)
end

set -l rvm_directory (mktemp -d)
cd $rvm_directory

mock rvm current "echo ruby-2.7.0"
set -lx tide_rvm_icon 

_rvm # CHECK:

touch .ruby-version
_rvm # CHECK:  ruby-2.7.0

rm -r $rvm_directory
