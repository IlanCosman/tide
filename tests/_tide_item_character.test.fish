# RUN: %fish %s
_tide_parent_dirs

function _character
    set -lx _tide_status $status
    set -lx _tide_pipestatus $pipestatus
    _tide_decolor (_tide_item_character)
end

set -lx tide_character_icon_failure ✘

# Check icons while fish_key_bindings is fish_default_key_bindings
set -lx fish_key_bindings fish_default_key_bindings

true
_character # CHECK: ❯

false
_character # CHECK: ✘

true | false
_character # CHECK: ✘

true | true
_character # CHECK: ❯

false | true
_character # CHECK: ❯

false | false
_character # CHECK: ✘

# Check that not command works
not true | false
_character # CHECK: ❯

not false | true
_character # CHECK: ✘

# Check icons while fish_key_bindings isn't fish_default_key_bindings
set -lx fish_key_bindings something_else
# Check icons while fish_bind_mode is default
set -lx fish_bind_mode default

true
_character # CHECK: ❮

false
_character # CHECK: ❮

true | false
_character # CHECK: ❮

true | true
_character # CHECK: ❮

false | true
_character # CHECK: ❮

false | false
_character # CHECK: ❮

# Check that not command works
not true | false
_character # CHECK: ❮

not false | true
_character # CHECK: ❮

# Check icons while fish_bind_mode is insert
set -lx fish_bind_mode insert

true
_character # CHECK: ❯

false
_character # CHECK: ✘

true | false
_character # CHECK: ✘

true | true
_character # CHECK: ❯

false | true
_character # CHECK: ❯

false | false
_character # CHECK: ✘

# Check that not command works
not true | false
_character # CHECK: ❯

not false | true
_character # CHECK: ✘

# Check icons while fish_bind_mode is replace
set -lx fish_bind_mode replace

true
_character # CHECK: ▶

false
_character # CHECK: ▶

true | false
_character # CHECK: ▶

true | true
_character # CHECK: ▶

false | true
_character # CHECK: ▶

false | false
_character # CHECK: ▶

# Check that not command works
not true | false
_character # CHECK: ▶

not false | true
_character # CHECK: ▶

# Check icons while fish_bind_mode is replace_one
set -lx fish_bind_mode replace_one

true
_character # CHECK: ▶

false
_character # CHECK: ▶

true | false
_character # CHECK: ▶

true | true
_character # CHECK: ▶

false | true
_character # CHECK: ▶

false | false
_character # CHECK: ▶

# Check that not command works
not true | false
_character # CHECK: ▶

not false | true
_character # CHECK: ▶

# Check icons while fish_bind_mode is visual
set -lx fish_bind_mode visual

true
_character # CHECK: V

false
_character # CHECK: V

true | false
_character # CHECK: V

true | true
_character # CHECK: V

false | true
_character # CHECK: V

false | false
_character # CHECK: V

# Check that not command works
not true | false
_character # CHECK: V

not false | true
_character # CHECK: V
