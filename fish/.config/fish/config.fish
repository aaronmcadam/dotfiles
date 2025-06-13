fish_add_path "/opt/homebrew/bin"
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.local/share/bob/nvim-bin"

set -gx SHELL "/opt/homebrew/bin/fish"

set -U fish_greeting # disable greeting
set -U fish_key_bindings fish_vi_key_bindings

set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx AWS_SDK_LOAD_CONFIG 1
# Configure lazy git configuration directory.
set -gx CONFIG_DIR ~/.config/lazygit

# Disable Husky git hooks
set -gx HUSKY 0

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# https://starship.rs/
starship init fish | source

# atuin
atuin init fish | source

# aliases and abbrs
source ~/.config/fish/aliases.fish

# include local settings and overrides
if test -e ~/.config/fish/config.local.fish
  source ~/.config/fish/config.local.fish
end
