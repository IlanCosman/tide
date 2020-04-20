function lean_user_ask --argument-names question options
    set -l optionList (string split "/" $options)

    for option in $optionList
        set -g upperOption (string upper $option)

        if contains $upperOption $optionList
            set -g default (_indexMinusOne $upperOption $optionList)
        end
    end

    while true
        read -P "$question [$options] " input

        set -l splitInput (string split -m1 '' $input)
        set -l lowerInput (string join '' (string lower $splitInput[1]) $splitInput[2])
        set -l upperInput (string join '' (string upper $splitInput[1]) $splitInput[2])

        if contains $lowerInput $optionList
            echo $lowerInput
            return (_indexMinusOne $lowerInput $optionList)
        end
        if contains $upperInput $optionList
            echo $upperInput
            return (_indexMinusOne $upperInput $optionList)
        end
        if test -z $input && set -q default
            echo $upperOption
            return $default
        end
    end
end

function _indexMinusOne --argument-names item
    echo (math (contains -i $item $argv[2..-1])-1)
end