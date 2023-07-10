# https://github.com/asdf-vm/asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish

# https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# https://starship.rs/
starship init fish | source

set -gx SHELL "/opt/homebrew/bin/fish"

# pnpm
set -gx PNPM_HOME "/Users/Aaron.Mcadam/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
