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
add_or_update_asdf_plugin "golang"
add_or_update_asdf_plugin "lua"
add_or_update_asdf_plugin "python"
add_or_update_asdf_plugin "ruby"

# This will install languages based on .tool-versions
asdf install

# if ! [[ $SHELL =~ "fish" ]]; then
  # fancy_echo "Configuring shell..."
  # echo "$(which fish)" | sudo tee -a /etc/shells
  # chsh -s $(which fish)
  # fish_add_path /opt/homebrew/bin
  # fancy_echo "Installing Fisher..."
  # curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
# fi

# fancy_echo "Fetching environment info..."
# neofetch
#
# fancy_echo "Starting fish..."
# fish
