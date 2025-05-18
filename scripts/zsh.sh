#!/bin/bash

echo "🔧 Setting up Zsh + plugins..."

ZINIT_DIR="$HOME/.local/share/zinit/zinit.git"

# Only clone Zinit if not already installed
if [ ! -d "$ZINIT_DIR" ]; then
  echo "📦 Installing Zinit..."
  mkdir -p ~/.local/share/zinit
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_DIR"
else
  echo "📦 Zinit already installed. Skipping clone."
fi

# Copy dotfiles only if they don’t already exist
copy_if_missing() {
  src="$1"
  dest="$2"
  if [ ! -f "$dest" ]; then
    cp "$src" "$dest"
    echo "📄 Copied $(basename "$src") → $dest"
  else
    echo "✅ $(basename "$dest") already exists. Skipping."
  fi
}

copy_if_missing "$HOME/bootstrap-macos/dotfiles/.zshrc" "$HOME/.zshrc"
copy_if_missing "$HOME/bootstrap-macos/dotfiles/.zsh_plugins.txt" "$HOME/.zsh_plugins.txt"
copy_if_missing "$HOME/bootstrap-macos/dotfiles/.zsh_aliases.txt" "$HOME/.zsh_aliases.txt"
copy_if_missing "$HOME/bootstrap-macos/dotfiles/.exports" "$HOME/.exports"

# Install Meslo Nerd Font (best-effort)
echo "🎨 Installing Meslo Nerd Font..."
brew install --cask font-meslo-lg-nerd-font || echo "⚠️ Font may already be installed or failed to install."

echo "✅ Zsh setup complete. Run 'source ~/.zshrc' or restart Warp."
