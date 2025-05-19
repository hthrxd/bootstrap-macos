#!/usr/bin/env zsh

################################################################################
# 🌱 PATH SETUP
################################################################################

if [ -d /opt/homebrew ]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
elif [ -d /usr/local/homebrew ]; then
  export PATH="/usr/local/homebrew/bin:/usr/local/homebrew/sbin:$PATH"
fi

export PATH="$HOME/.local/bin:$HOME/.local/sbin:$HOME/.volta/bin:$PATH"

################################################################################
# 💎 rbenv
################################################################################

if command -v rbenv &> /dev/null; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  export RUBY_LATEST=$(rbenv install -l 2>/dev/null | awk '$1 ~ /^[0-9.]*$/ {latest=$1} END {print latest}')
  rbenv global "$RUBY_LATEST"
fi

################################################################################
# 🐍 pyenv
################################################################################

if command -v pyenv &> /dev/null; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

################################################################################
# ⚙️ Zinit Plugin Manager
################################################################################

if [[ ! -f "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  echo "🔧 Installing Zinit..."
  mkdir -p "$HOME/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# Load plugins from dotfiles-managed plugin list
zinit light-mode for \
  ${(f)"$(grep -v '^#' "$HOME/bootstrap-macos/dotfiles/.zsh_plugins.txt")"}

# Ensure syntax highlighter loads last (best practice)
if grep -q "zsh-users/zsh-syntax-highlighting" "$HOME/bootstrap-macos/dotfiles/.zsh_plugins.txt"; then
  zinit light zsh-users/zsh-syntax-highlighting
elif grep -q "fast-syntax-highlighting" "$HOME/bootstrap-macos/dotfiles/.zsh_plugins.txt"; then
  zinit light zdharma-continuum/fast-syntax-highlighting
fi

################################################################################
# 🧁 Custom Dotfiles
################################################################################

[[ -f "$HOME/bootstrap-macos/dotfiles/.exports" ]] && source "$HOME/bootstrap-macos/dotfiles/.exports"
[[ -f "$HOME/bootstrap-macos/dotfiles/.zsh_aliases.txt" ]] && source "$HOME/bootstrap-macos/dotfiles/.zsh_aliases.txt"

################################################################################
# 🎨 Powerlevel10k Theme (if installed)
################################################################################

[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

################################################################################
# 🧽 Zsh Behavior & Prompt Enhancements
################################################################################

autoload -Uz compinit promptinit
compinit
promptinit

setopt autocd
setopt correct
setopt extended_glob
setopt hist_ignore_dups
setopt share_history

# Set terminal title
precmd() { print -Pn "\e]0;%n@%m: %~\a" }
