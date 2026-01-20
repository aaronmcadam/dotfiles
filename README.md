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
./install.sh asdf     # install asdf plugins and languages
```

### Notes

- **Fish plugins**: Tracked in `fish/.config/fish/fish_plugins` - add plugins with `fisher install <plugin>` and they'll be saved automatically
- **Stow conflicts**: If stow fails because a target file already exists (e.g., atuin config), use `stow --adopt */` to pull the existing file into dotfiles and create the symlink

### Partial Directory Tracking

Some tools have directories containing both config we want to track and auto-generated files we don't (plugin files, caches, state). By default, stow symlinks entire directories, which would cause those generated files to end up in the repo.

**Solution**: Use `--no-folding` in `.stowrc`. This makes stow create real directories and only symlink individual files. Generated files stay local and never end up in dotfiles.

**Example - Fish**: The `functions/` directory contains both custom functions (`mcd.fish`, `gwc.fish`) and Fisher plugin files. With `--no-folding`, stow symlinks only our custom functions while Fisher's plugins remain as regular files.

**Example - Claude**: The `~/.claude/` directory contains custom commands/skills alongside generated files (history, cache). With `--no-folding`, stow symlinks only the files in dotfiles while Claude's runtime files stay local.

## AzVim

My Neovim distribution is called [AzVim](https://github.com/aaronmcadam/dotfiles/tree/main/nvim/.config/nvim).

## Inspiration

The following repos were useful when building these files:

- https://github.com/thoughtbot/dotfiles
- https://github.com/thoughtbot/laptop
- https://github.com/LunarVim/nvim-basic-ide
- https://github.com/Mach-OS/Machfiles
