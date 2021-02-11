# RUN: %fish %s

function _context
    _tide_decolor (_tide_item_context)
end

set -lx tide_context_always_display false
_context # Check:

set -lx tide_context_always_display true
_context # CHECK: {{.*@.*}}

set -g SSH_TTY /dev/pts/0
_context # CHECK: {{.*@.*}}

set USER root
_context # CHECK: {{root@.*}}
