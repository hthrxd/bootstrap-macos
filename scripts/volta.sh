#!/bin/bash

echo "⚙️ Setting up Volta and JavaScript toolchain..."

# Install Volta only if not present
if ! command -v volta &> /dev/null; then
  curl https://get.volta.sh | bash
  echo "✅ Volta installed. Restart your terminal if this is the first install."
  export PATH="$HOME/.volta/bin:$PATH"
else
  echo "✅ Volta already installed. Skipping."
fi

# Install tools only if they aren’t already installed
volta install node
volta install npm
volta install yarn
volta install pnpm

echo "✅ Node.js, npm, yarn, and pnpm installed via Volta."
