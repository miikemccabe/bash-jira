#!/bin/bash

set -e  # Exit immediately on error

SCRIPT_NAME="jira"
INSTALL_DIR="$HOME/bin"

SCRIPT_URL="https://raw.githubusercontent.com/miikemccabe/bash-jira/refs/heads/main/$SCRIPT_NAME"
TARGET_PATH="$INSTALL_DIR/$SCRIPT_NAME"

# Step 0: Prompt
echo "📦 This script will:"
echo "1. Download '$SCRIPT_NAME' from: $SCRIPT_URL"
echo "2. Save it to: $TARGET_PATH"
echo "3. Make it executable"
echo "4. Add '$HOME/bin' to your PATH if it's not already"
echo
read -p "Do you want to continue? (y/n) " -r

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "❌ Installation cancelled."
  exit 1
fi

# Step 1: Ensure $HOME/bin exists
mkdir -p "$INSTALL_DIR"

# Step 2: Download the script
curl -fsSL "$SCRIPT_URL" -o "$TARGET_PATH"
chmod +x "$TARGET_PATH"

echo "✅ Script downloaded to $TARGET_PATH"

# Step 3: Ensure $HOME/bin is in PATH
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
  if [[ "$SHELL" == */zsh ]]; then
    PROFILE_FILE="$HOME/.zshrc"
  else
    PROFILE_FILE="$HOME/.bash_profile"
  fi

  echo 'export PATH="$HOME/bin:$PATH"' >> "$PROFILE_FILE"
  echo "➕ Added \$HOME/bin to your PATH in $PROFILE_FILE"
  echo "🔄 Please restart your terminal or run: source $PROFILE_FILE"
else
  echo "📎 \$HOME/bin is already in your PATH"
fi

echo "🎉 Done! You can now run '$SCRIPT_NAME' from anywhere."
