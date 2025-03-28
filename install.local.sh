#!/bin/bash

set -e  # Exit immediately on error

SCRIPT_NAME="jira"
INSTALL_DIR="$HOME/bin"
TARGET_PATH="$INSTALL_DIR/$SCRIPT_NAME"

# Step 1: Ensure $HOME/bin exists
mkdir -p "$INSTALL_DIR"

# Step 2: Install the script
cp ./jira "$TARGET_PATH"
chmod +x "$TARGET_PATH"

echo "✅ Script installed to $TARGET_PATH"

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
