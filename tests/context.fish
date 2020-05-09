# Fishtape test
set -l sourceFile "$__fish_config_dir/functions/lean_right_prompt.fish"
source $sourceFile

function _context
    lean_decolor (_lean_context)
end

@test 'None' (_context) -z
@test 'SSH' (set -g SSH_TTY 'true'; _context) = $USER'@'(prompt_hostname)
@test 'Root' (lean_decolor (su -c "source $sourceFile;_lean_context")) = 'root@'(prompt_hostname)