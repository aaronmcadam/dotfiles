# https://github.com/asdf-vm/asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish

# https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# https://starship.rs/
starship init fish | source

# pnpm
set -gx PNPM_HOME "/Users/Aaron.Mcadam/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end