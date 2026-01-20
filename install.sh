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

  fancy_echo "Installing Fisher and plugins from fish_plugins..."
  fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update'
}

install_stow() {
  fancy_echo "Linking dotfiles..."
  stow */
}

install_dnsmasq() {
  fancy_echo "Setting up .test domains for local development..."

  if ! brew list dnsmasq &>/dev/null; then
    brew install dnsmasq
  fi

  # Configure dnsmasq to resolve .test to localhost
  if ! grep -q "address=/.test/127.0.0.1" "$(brew --prefix)/etc/dnsmasq.conf" 2>/dev/null; then
    echo "address=/.test/127.0.0.1" >> "$(brew --prefix)/etc/dnsmasq.conf"
  fi

  # Start dnsmasq service
  sudo brew services start dnsmasq

  # Configure macOS to use dnsmasq for .test domains
  sudo mkdir -p /etc/resolver
  echo "nameserver 127.0.0.1" | sudo tee /etc/resolver/test

  if ping -c 1 demo.test &>/dev/null; then
    fancy_echo "✓ .test domains configured successfully"
  else
    fancy_echo "✗ Failed to resolve demo.test - check dnsmasq config"
  fi
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
  install_stow
  install_fish
  install_asdf
  fastfetch
}

show_help() {
  echo "Usage: ./install.sh [command]"
  echo ""
  echo "Commands:"
  echo "  all      Run full installation"
  echo "  brew     Install Homebrew and apps"
  echo "  fish     Configure Fish shell"
  echo "  stow     Link dotfiles with stow"
  echo "  asdf     Install asdf plugins and languages"
  echo "  dnsmasq  Setup .test domains for local dev"
  echo ""
  echo "If no command is given, shows this help."
}

case "${1:-}" in
  all)     install_all ;;
  brew)    install_brew ;;
  fish)    install_fish ;;
  stow)    install_stow ;;
  asdf)    install_asdf ;;
  dnsmasq) install_dnsmasq ;;
  *)       show_help ;;
esac
