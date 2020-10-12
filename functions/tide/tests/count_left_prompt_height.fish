@mesg '---------count_left_prompt_height---------'

function _count_left_prompt_height
    set -lx tide_left_prompt_items $argv
    _tide_count_left_prompt_height
    printf '%s' $_tide_left_prompt_height
end

@test 'Single line' (_count_left_prompt_height pwd git_prompt prompt_char) -eq 1
@test 'Double line' (_count_left_prompt_height pwd git_prompt newline prompt_char) -eq 2