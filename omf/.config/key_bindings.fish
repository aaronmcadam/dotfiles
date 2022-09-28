# General
alias ... "cd ../../.."
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
alias ls "exa"
alias r "rm"
alias rr "rm -rf"
alias v "nvim"
alias v. "nvim"
alias zz "z -"

# JavaScript
abbr -a n "npm install"
abbr -a nt "npm test"
abbr -a ntw "npm test -- --watch"
abbr -a nx "yarn nx"
abbr -a y "yarn"
abbr -a yd "yarn dev"
abbr -a ys "yarn start"
abbr -a ysb "yarn storybook"
abbr -a yt "yarn test"
abbr -a ytw "yarn test --watch"

# Git
alias gdb "git branch | fzf -m | xargs -n 1 git branch -D"
abbr -a grbi git rebase --interactive
abbr -a grbim git rebase --interactive main
abbr -a grbil git rebase --interactive HEAD~2
abbr -a s "git status -s"
abbr -a h "gh"
abbr -a hb "gh browse"
abbr -a hc "gh repo clone"

# Tools
alias tat "~/.bin/tat"
