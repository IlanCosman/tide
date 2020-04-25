function _lean_right_prompt_nocolor
    echo -n " "
    
    for module in lean_{$lean_right_prompt_modules}
        if test -n "$$module"
            echo -n "$$module"
            echo -n " "
        end
    end
end