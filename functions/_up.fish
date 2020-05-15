function _up -a number
    if test $number -ne 0
        echo -ne '\033['$number'A'
    end
end