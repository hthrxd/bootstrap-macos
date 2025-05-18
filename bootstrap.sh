#!/bin/bash

echo "🚀 Starting Heather's Bootstrap Setup..."

set -e  # Stop on any error

# Run each setup script
source ./scripts/zsh.sh
source ./scripts/volta.sh
source ./scripts/qa-dev.sh

echo "🌸 All done! Welcome to your new dev environment, Heather 💖"
