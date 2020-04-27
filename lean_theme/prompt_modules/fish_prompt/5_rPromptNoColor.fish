function _lean_right_prompt_nocolor
    echo -n " "
    
    for item in lean_{$lean_right_prompt_items}
        if test -n "$$item"
            echo -n "$$item"
            echo -n " "
        end
    end
end