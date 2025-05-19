#!/bin/bash

echo "🔧 Installing CLI tools for Heather-core shell environment..."

# Update Homebrew
echo "🍺 Updating Homebrew..."
brew update

# ─────────────────────────────────────────────
# Core Tools
# ─────────────────────────────────────────────

echo "📦 Installing fzf (fuzzy finder)..."
brew install fzf
"$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc

echo "🎨 Installing diff-so-fancy..."
brew install diff-so-fancy

echo "📁 Installing autojump..."
brew install autojump

echo "☁️ Installing AWS CLI..."
brew install awscli

echo "📋 Installing JIRA CLI..."
brew tap jira-cli/tap
brew install jira-cli

echo "💠 Installing Meslo Nerd Font (for Powerlevel10k)..."
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font

echo "✅ All tools installed successfully!"
