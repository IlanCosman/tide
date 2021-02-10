# RUN: %fish %s

set -l sourceFile "$_tide_root/functions/_tide_item_context.fish"

function _context
    _tide_decolor (_tide_item_context)
end

set -lx tide_context_always_display false
_context # Check:

set -lx tide_context_always_display true
_context # CHECK: {{.*@.*}}

set -g SSH_TTY /dev/pts/0
_context # CHECK: {{.*@.*}}

_tide_decolor (sudo fish --command="source $sourceFile;_tide_item_context") # CHECK: {{root@.*}}
