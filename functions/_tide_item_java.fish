function _tide_item_java
    test -e pom.xml && _tide_print_item java $tide_java_icon' ' (set jv (java -version 2>&1 | head -1 | string split ' ')[3]; echo $jv | string trim -c '"')
end
