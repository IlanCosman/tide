@mesg '-----------context-----------'

set -l sourceFile "$__fish_config_dir/functions/_tide_item_context.fish"

function _context
    _tide_decolor (_tide_item_context)
end

@test 'None' (set -lx tide_context_always_display false; _context) -z
@test 'Default' (set -lx tide_context_always_display true; _context ) = $USER'@'$hostname
@test 'SSH' (set -g SSH_TTY 'true'; _context) = $USER'@'$hostname
@test 'Root' (_tide_decolor (sudo fish --command="source $sourceFile;_tide_item_context")) = 'root@'$hostname