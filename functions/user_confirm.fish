function user_confirm
    set -l question $argv[1]
    set -l rule $argv[2]
    set -l splitRule (string split "/" $rule)

    while true
        read -P "$question [$rule] " confirm

        switch $confirm
            case Y y Yes yes
                return 0
            case N n No no
                return 1
            case ''
                if test (string sub -l 1 $splitRule[1]) = "Y"
                    return 0
                end
                if test (string sub -l 1 $splitRule[2]) = "N"
                    return 1
                end
        end
    end
end