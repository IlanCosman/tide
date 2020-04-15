echo "Installing lean theme..."

# -----------------Download Functions-----------------
set fns fish_prompt lean_git_prompt lean_pwd lean_uninstall user_ask
set githubFnsDir "https://raw.githubusercontent.com/IlanCosman/lean/master/functions"

for fn in $fns
    wget -q "$githubFnsDir/$fn.fish" -O "$__fish_config_dir/functions/$fn.fish"
end

# ----------------Set Theme Variables----------------
# --------------Colors--------------
set -U lean_green 5FD700
set -U lean_light_blue 00AFFF
set -U lean_dark_blue 0087AF
set -U lean_gold D7AF00
# ---------------Pwd---------------
set -U fish_prompt_pwd_dir_length 0
set -U lean_shorten_pwd_margin 5
# ------------Git prompt------------
set -U __fish_git_prompt_show_informative_status true
set -U __fish_git_prompt_showstashstate true
# -------Symbols-------
set -U __fish_git_prompt_char_stateseparator ""
set -U __fish_git_prompt_char_cleanstate ""
set -U __fish_git_prompt_char_upstream_ahead " ⇡"
set -U __fish_git_prompt_char_upstream_behind " ⇣"
set -U __fish_git_prompt_char_stagedstate " +"
set -U __fish_git_prompt_char_dirtystate ' !'
set -U __fish_git_prompt_char_untrackedfiles ' ?'
set -U __fish_git_prompt_char_stashstate " *"
# --------Colors--------
set -U __fish_git_prompt_color_branch $lean_green
set -U __fish_git_prompt_color_upstream $lean_green
set -U __fish_git_prompt_color_stagedstate $lean_gold
set -U __fish_git_prompt_color_dirtystate $lean_gold
set -U __fish_git_prompt_color_untrackedfiles $lean_light_blue
set -U __fish_git_prompt_color_stashstate $lean_green

set_color $lean_green
echo "Lean theme installed! Restart fish to see your new prompt."
set_color $fish_color_normal