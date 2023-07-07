function _tide_item_java
    if path is $_tide_parent_dirs/pom.xml
        java -version &| string match -qr "(?<v>[\d.]+)"
        _tide_print_item java $tide_java_icon' ' $v
    end
end
