#!/bin/bash

echo "🧪 Setting up Cypress and Playwright..."

DEV_DIR="$HOME/qa-dev"

mkdir -p "$DEV_DIR"
cd "$DEV_DIR"

# Initialize package.json only if it doesn’t exist
if [ ! -f "package.json" ]; then
  npm init -y
else
  echo "✅ package.json already exists. Skipping init."
fi

# Install Cypress if not already installed
if ! npm list --depth=0 | grep -q "cypress@"; then
  npm install --save-dev cypress
else
  echo "✅ Cypress already installed."
fi

# Install Playwright if not already installed
if ! npm list --depth=0 | grep -q "playwright@"; then
  npm install --save-dev playwright
  npx playwright install
else
  echo "✅ Playwright already installed."
fi

echo "✅ Cypress & Playwright dev setup complete in ~/qa-dev"
