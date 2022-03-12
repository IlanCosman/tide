function _tide_item_java
    test -e pom.xml && _tide_print_item java $tide_java_icon' ' (java --version | string split ' ')[2]
end
