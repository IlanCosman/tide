function lean_right_prompt
    echo -n " "
    
    for module in lean_{$lean_right_prompt_modules}
        if test -n "$$module"
            set -l colorName "$module"_color
            
            set_color "$$colorName"
            echo -n "$$module"
            echo -n " "
            set_color normal
        end
    end
end