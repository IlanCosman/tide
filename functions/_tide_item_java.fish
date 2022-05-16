function _tide_item_java
    test -e pom.xml && _tide_print_item java $tide_java_icon' ' (java -version &| string match -r "[\d.]+")[1]
end
