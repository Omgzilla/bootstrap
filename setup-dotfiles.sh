#!/bin/env bash

HOME="/home/$($USER)"
REPO_DIR="$HOME/.local"
REPO_NAME="dots"
REPO_URL="https://github.com/Omgzilla/dots"

is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

# Check if stow is installed
if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

# Check if `.local/bin` exists
if [ -d "$HOME/.local/bin" && -d "$HOME/.config" ]; then
  continue
else
  mkdir -p $HOME/.local/bin
  mkdir -p $HOME/.config
fi

# Check if the repository already exists
if [ -d "$REPO_DIR/$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists, skipping clone"
else
  git clone "$REPO_URL" "$REPO_DIR"/"$REPO_NAME"
fi

# Check if clone was successful
if [ $? -eq 0 ]; then
  cd "$REPO_DIR"/"$REPO_NAME"
  stow -t ~/ .
else
  echo "Failed to clone the repository."
  exit 1
fi
