@mesg '-----------context-----------'

set -l sourceFile "$__fish_config_dir/functions/_tide_context.fish"

function _context
    tide_decolor (_tide_context)
end

@test 'None' (_context) -z
@test 'SSH' (set -g SSH_TTY 'true'; _context) = $USER'@'(prompt_hostname)' '
@test 'Root' (tide_decolor (su -c "fish -c 'source $sourceFile;_tide_context'")) = 'root@'(prompt_hostname)' '