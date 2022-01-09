# RUN: %fish %s

function _java
    _tide_decolor (_tide_item_java)
end

set -l javaDir (mktemp -d)
cd $javaDir

mock java --version "echo 'openjdk 17.0.1 2021-10-19
OpenJDK Runtime Environment (build 17.0.1+12)
OpenJDK 64-Bit Server VM (build 17.0.1+12, mixed mode)'"

set -lx tide_java_icon 

_java # CHECK:

touch pom.xml
_java # CHECK:  17.0.1

rm -r $javaDir
