# ASDF first
set -gx ASDF_DIR $HOME/.asdf
test -f $ASDF_DIR/asdf.fish; and source $ASDF_DIR/asdf.fish

# Use fish_add_path for idempotent, de-duplicated PATH
# Prepend shims/bin, then append Homebrew and others once
fish_add_path --prepend $ASDF_DIR/shims $ASDF_DIR/bin
fish_add_path /opt/homebrew/bin /opt/homebrew/sbin
fish_add_path $HOME/bin $HOME/.local/share/bob/nvim-bin

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

# pnpm
set -gx PNPM_HOME "/Users/aaron/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
