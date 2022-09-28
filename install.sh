#!/bin/sh

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

fancy_echo "Installing programs..."
brew update
brew bundle --file brew/Brewfile
brew cleanup

fancy_echo "Linking dotfiles..."
stow */

fancy_echo "Configuring programming tools..."

add_or_update_asdf_plugin() {
  local name="$1"

  if ! asdf plugin-list | grep -Fq "$name"; then
    asdf plugin-add "$name"
  else
    asdf plugin-update "$name"
  fi
}

add_or_update_asdf_plugin "nodejs"
# For AWS CLI
add_or_update_asdf_plugin "python"
# This will install languages based on .tool-versions
asdf install
# Install Yarn with NPM
npm install --global yarn
npm install -g eslint_d

if ! [[ $SHELL =~ "fish" ]]; then
  fancy_echo "Configuring shell..."
  echo "$(which fish)" | sudo tee -a /etc/shells
  chsh -s $(which fish)
  fancy_echo "Installing oh-my-fish..."
  curl -L https://get.oh-my.fish > install-omf
  fish install-omf --noninteractive
  fish -c "omf install https://github.com/jhillyerd/plugin-git"
fi

fancy_echo "Fetching environment info..."
neofetch

fancy_echo "Starting fish..."
fish
