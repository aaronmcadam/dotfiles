fish_add_path "/opt/homebrew/bin"
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.local/share/bob/nvim-bin"

set -gx SHELL "/opt/homebrew/bin/fish"

# include local settings
if test -e ~/.config/fish/config.local.fish
  source ~/.config/fish/config.local.fish
end

set -U fish_greeting # disable greeting
set -U fish_key_bindings fish_vi_key_bindings

set -gx VISUAL nvim
set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx AWS_SDK_LOAD_CONFIG 1
# Configure lazy git configuration directory.
set -gx CONFIG_DIR ~/.config/lazygit

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

# keybindings
# General
alias ... "cd ../.."
alias ag "rg"
alias c "clear"
alias cat "bat"
alias cd "z"
alias htop "btop"
alias change-bindings "v ~/.config/omf/key_bindings.fish"
alias update-brewfile "brew bundle dump -f"
alias l "eza --long --all --git --icons --no-user"
alias ls "eza --long --all --git --icons --no-user"
alias lt "eza --long --all --git --icons --tree --level=2"
abbr -a lg "lazygit"
abbr -a r "rm"
abbr -a rr "rm -rf"
abbr -a v "nvim"
abbr -a v. "nvim"
abbr -a update-vim-plugins "nvim --headless '+Lazy! sync' +qa"
abbr -a zz "z -"
abbr -a work "zellij -l work"

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
alias grbim "git fetch origin main && git rebase --interactive origin/main"

abbr -a gwc "git create-worktree"
abbr -a gwcb "git create-worktree -b"

# Remove the current git worktree and navigate to the repo root
# and list worktrees to show the worktree has been removed.
# Must be run from within the worktree directory
alias gwr "git worktree remove . --force && cd .. && git worktree list"

abbr -a grbi git rebase --interactive
abbr -a grbil git rebase --interactive HEAD~2
abbr -a s "git status -s"
abbr -a h "gh"
abbr -a hb "gh browse"
abbr -a hc "gh repo clone"
