# aliases and abbrs

# General
alias ... "cd ../.."
alias ag "rg"
alias c "clear"
alias cat "bat"
alias cd "z"
alias htop "btop"
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
