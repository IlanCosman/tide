# RUN: %fish %s

function _php
    _tide_decolor (_tide_item_php)
end

set -l phpDir (mktemp -d)
cd $phpDir

mock php --version "echo \
'PHP 8.0.2 (cli) (built: Feb  2 2021 18:26:02) ( NTS )
Copyright (c) The PHP Group
Zend Engine v4.0.2, Copyright (c) Zend Technologies'"

_php # CHECK:

touch composer.json
_php # CHECK:  8.0.2

rm -r $phpDir
