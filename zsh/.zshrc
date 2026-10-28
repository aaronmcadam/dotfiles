# zsh is only used by Claude Code's Bash tool (the terminal shell is fish).
# Claude Code reads this file at session start and applies its options to
# every command it runs.

# Pass a glob that matches nothing through as plain text, as bash does,
# instead of aborting the whole command with "no matches found".
setopt NO_NOMATCH
