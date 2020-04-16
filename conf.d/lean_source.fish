if not test -e "$__fish_config_dir/functions/fish_prompt.fish"
    for file in $__fish_config_dir/lean_theme/*
        source $file
    end
end