fish_add_path "/opt/homebrew/bin"

set -U fish_greeting # disable greeting
set -U fish_key_bindings fish_vi_key_bindings

set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx AWS_SDK_LOAD_CONFIG 1
# Configure lazy git configuration directory.
set -gx CONFIG_DIR ~/.config/lazygit

# https://github.com/asdf-vm/asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish

# https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# https://starship.rs/
starship init fish | source

set -gx SHELL "/opt/homebrew/bin/fish"

# keybindings
# General
alias ... "cd ../.."
alias ag "rg"
alias c "clear"
alias cat "bat"
alias cd "z"
alias change-bindings "v ~/.config/omf/key_bindings.fish"
alias update-brewfile "brew bundle dump -f"
alias co "code"
alias fr "fish"
alias l "exa -la"
alias lg "lazygit"
alias ls "exa -la"
alias r "rm"
alias rr "rm -rf"
alias v "nvim"
alias v. "nvim"
alias update-vim-plugins "nvim --headless '+Lazy! sync' +qa"
alias zz "z -"

# JavaScript
abbr -a n "npm install"
abbr -a nt "npm test"
abbr -a ntw "npm test -- --watch"
abbr -a nx "pnpm nx"
abbr -a y "yarn"
abbr -a yd "yarn dev"
abbr -a ys "yarn start"
abbr -a ysb "yarn storybook"
abbr -a yt "yarn test"
abbr -a ytw "yarn test --watch"
abbr -a p "pnpm"
abbr -a pi "pnpm i"
abbr -a pd "pnpm dev"
abbr -a psb "pnpm storybook"
abbr -a pt "pnpm test"
abbr -a ptw "pnpm test --watch"

# Git
alias gdb "git branch | fzf --header 'Delete Branch' --reverse -m --pointer='' | xargs -n 1 git branch -D"
alias gcr "git branch --sort=-committerdate | fzf --header 'Checkout Recent Branch' --preview 'git diff --color=always {1}' --reverse -m --pointer='' | xargs -n 1 git checkout"
alias gv "nvim '+:horizontal topleft Git'"
abbr -a grbi git rebase --interactive
abbr -a grbim git rebase --interactive main
abbr -a grbil git rebase --interactive HEAD~2
abbr -a s "git status -s"
abbr -a h "gh"
abbr -a hb "gh browse"
abbr -a hc "gh repo clone"

# pnpm
set -gx PNPM_HOME "/Users/aaronmcadam/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
