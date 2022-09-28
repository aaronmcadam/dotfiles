#!/bin/sh

# see https://github.com/thoughtbot/laptop/blob/master/mac
fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

fancy_echo "Updating Homebrew formulae..."
brew update
brew bundle --file brew/Brewfile
brew cleanup

fancy_echo "Linking dotfiles..."
stow */

fancy_echo "Configuring asdf version manager..."

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

# TODO: We need to change the shell to fish to access the omf command.
# fish_add_path /opt/homebrew/bin
# echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
# chsh -s /opt/homebrew/bin/fish
# We might want to run this after the initial install
# if ! command -v omf >/dev/null; then
#   fancy_echo "Installing oh-my-fish..."
#   curl -L https://get.oh-my.fish | fish
#   omf install https://github.com/jhillyerd/plugin-git
# fi
