@mesg '-----------context-----------'

set -l sourceFile "$__fish_config_dir/functions/_tide_item_context.fish"

function _context
    _tide_decolor (_tide_item_context)
end

@test 'None' (_context) -z
@test 'SSH' (set -g SSH_TTY 'true'; _context) = $USER'@'$hostname
@test 'Root' (_tide_decolor (sudo fish --command="source $sourceFile;_tide_item_context")) = 'root@'$hostname