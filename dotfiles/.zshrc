#!/usr/bin/env zsh

################################################################################
# 💻 Homebrew                                                                  #
################################################################################

if [ -d /opt/homebrew ]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
elif [ -d /usr/local/homebrew ]; then
  export PATH="/usr/local/homebrew/bin:/usr/local/homebrew/sbin:$PATH"
fi

################################################################################
# 📂 Local Binaries                                                            #
################################################################################

export PATH="$HOME/.local/bin:$HOME/.local/sbin:$PATH"

################################################################################
# 💎 Ruby (rbenv)                                                              #
################################################################################

if command -v rbenv &> /dev/null; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  export RUBY_LATEST=$(rbenv install -l 2>/dev/null | awk '$1 ~ /^[0-9.]*$/ {latest=$1} END {print latest}')
  rbenv global "$RUBY_LATEST"
fi

################################################################################
# 🐍 Python (pyenv)                                                            #
################################################################################

if command -v pyenv &> /dev/null; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

################################################################################
# 🌈 Volta (Node, npm, yarn, pnpm)                                             #
################################################################################

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

################################################################################
# 📄 Load Exports & Aliases                                                    #
################################################################################

[[ -f "$HOME/.exports" ]] && source "$HOME/.exports"
[[ -f "$HOME/.zsh_aliases.txt" ]] && source "$HOME/.zsh_aliases.txt"

################################################################################
# ⚙️ Zinit Plugin Manager                                                      #
################################################################################

if [[ ! -f "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  echo "🔧 Installing Zinit..."
  mkdir -p "$HOME/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi

source "$HOME/.local/share/zinit/zinit.zsh"

# Load plugins from ~/.zsh_plugins.txt
for plugin in ${(f)"$(<~/.zsh_plugins.txt)"}; do
  if [[ "$plugin" == zinit\ snippet* ]]; then
    eval "$plugin"
  else
    zinit light "$plugin"
  fi
done

# Always ensure a syntax highlighter loads LAST
if grep -q "zsh-users/zsh-syntax-highlighting" ~/.zsh_plugins.txt; then
  zinit light zsh-users/zsh-syntax-highlighting
elif grep -q "fast-syntax-highlighting" ~/.zsh_plugins.txt; then
  zinit light zdharma-continuum/fast-syntax-highlighting
fi

################################################################################
# 🎨 Prompt Theme                                                              #
################################################################################

[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

################################################################################
# 🧽 Zsh Behavior                                                              #
################################################################################

setopt prompt_subst
autoload -Uz compinit promptinit
compinit
promptinit

setopt autocd
setopt correct
setopt extended_glob
setopt hist_ignore_dups
setopt share_history

# Optional: Show terminal title
precmd() { print -Pn "\e]0;%n@%m: %~\a" }
