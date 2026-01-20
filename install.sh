#!/bin/bash

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

# If running a fresh install, generate a new SSH key first:
# ssh-keygen -t ed25519 -C "your_email@example.com"
# Now add it to GitHub:
# @see https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

install_brew() {
  if ! command -v brew >/dev/null; then
    fancy_echo "Installing Homebrew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  fancy_echo "Installing apps..."
  brew update
  brew bundle --file brew/Brewfile
  brew cleanup

  fancy_echo "Installing neovim..."
  bob use stable
}

install_fish() {
  fancy_echo "Creating local shell config..."
  cp fish/.config/fish/config.local.example.fish fish/.config/fish/config.local.fish

  if ! [[ $SHELL =~ "fish" ]]; then
    fancy_echo "Configuring shell..."
    echo "$(which fish)" | sudo tee -a /etc/shells
    chsh -s $(which fish)
  fi

  fancy_echo "Installing Fisher..."
  fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'

  if fish -c 'type -q fisher'; then
    fancy_echo "Fisher installed successfully"
    fancy_echo "Installing fish plugins from fish_plugins..."
    fish -c 'fisher update'
  else
    fancy_echo "Fisher installation failed"
    return 1
  fi
}

install_stow() {
  fancy_echo "Linking dotfiles..."
  stow */
}

install_asdf() {
  fancy_echo "Configuring programming tools..."

  add_or_update_asdf_plugin() {
    local name="$1"

    if ! asdf plugin list | grep -Fq "$name"; then
      asdf plugin add "$name"
    else
      asdf plugin update "$name"
    fi
  }

  add_or_update_asdf_plugin "nodejs"
  add_or_update_asdf_plugin "golang"
  add_or_update_asdf_plugin "lua"
  add_or_update_asdf_plugin "python"
  add_or_update_asdf_plugin "ruby"

  # This will install languages based on .tool-versions
  asdf install
}

install_all() {
  install_brew
  install_fish
  install_stow
  install_asdf
  fastfetch
}

show_help() {
  echo "Usage: ./install.sh [command]"
  echo ""
  echo "Commands:"
  echo "  all     Run full installation"
  echo "  brew    Install Homebrew and apps"
  echo "  fish    Configure Fish shell"
  echo "  stow    Link dotfiles with stow"
  echo "  asdf    Install asdf plugins and languages"
  echo ""
  echo "If no command is given, shows this help."
}

case "${1:-}" in
  all)    install_all ;;
  brew)   install_brew ;;
  fish)   install_fish ;;
  stow)   install_stow ;;
  asdf)   install_asdf ;;
  *)      show_help ;;
esac
