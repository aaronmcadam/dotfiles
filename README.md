# dotfiles

TypeScript development with neovim.

## Installation

Run specific parts of the setup:

```bash
./install.sh          # show available commands
./install.sh all      # full installation
./install.sh brew     # install Homebrew and apps
./install.sh fish     # configure Fish shell + Fisher plugins
./install.sh stow     # link dotfiles with stow
./install.sh claude   # link Claude config
./install.sh asdf     # install asdf plugins and languages
```

### Notes

- **Stow**: The `claude/` directory is ignored by stow (via `.stowrc`) and handled separately
- **Fish plugins**: Tracked in `fish/.config/fish/fish_plugins` - add plugins with `fisher install <plugin>` and they'll be saved automatically
- **Claude config**: Only `commands/` and `skills/` are symlinked to `~/.claude`, keeping runtime files out of the repo

## AzVim

My Neovim distribution is called [AzVim](https://github.com/aaronmcadam/dotfiles/tree/main/nvim/.config/nvim).

## Inspiration

The following repos were useful when building these files:

- https://github.com/thoughtbot/dotfiles
- https://github.com/thoughtbot/laptop
- https://github.com/LunarVim/nvim-basic-ide
- https://github.com/Mach-OS/Machfiles
