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
abbr -a ps "pnpm start"
abbr -a psb "pnpm storybook"
abbr -a pt "pnpm test"
abbr -a ptw "pnpm test --watch"

# Git
alias gdb "git branch | fzf --header 'Delete Branch' --reverse -m --pointer='' | xargs -n 1 git branch -D"
alias gcr "git branch --sort=-committerdate | fzf --header 'Checkout Recent Branch' --preview 'git diff --color=always {1}' --reverse -m --pointer='' | xargs -n 1 git checkout"
abbr -a grbi git rebase --interactive
abbr -a grbim git rebase --interactive main
abbr -a grbil git rebase --interactive HEAD~2
abbr -a s "git status -s"
abbr -a h "gh"
abbr -a hb "gh browse"
abbr -a hc "gh repo clone"

# Tools
alias tat "~/bin/tat"
