#!/bin/bash

# Add nvim alias to shell configuration
ALIAS_LINE="alias vi='nvim'"

# Detect shell and set appropriate config file
if [ -n "$BASH_VERSION" ]; then
    CONFIG_FILE="$HOME/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    CONFIG_FILE="$HOME/.zshrc"
else
    # Default to bashrc
    CONFIG_FILE="$HOME/.bashrc"
fi

# Check if alias already exists
if grep -q "alias vi='nvim'" "$CONFIG_FILE" 2>/dev/null; then
    echo "Alias already exists in $CONFIG_FILE"
else
    echo "$ALIAS_LINE" >> "$CONFIG_FILE"
    echo "Added alias to $CONFIG_FILE"
    echo "Run 'source $CONFIG_FILE' or restart your shell to apply changes"
fi

# Set neovim as default editor
EDITOR_EXPORTS="export EDITOR='nvim'\nexport VISUAL='nvim'"

# Check if EDITOR is already set to nvim
if grep -q "export EDITOR='nvim'" "$CONFIG_FILE" 2>/dev/null; then
    echo "EDITOR already set to nvim in $CONFIG_FILE"
else
    echo -e "\n$EDITOR_EXPORTS" >> "$CONFIG_FILE"
    echo "Set EDITOR and VISUAL to nvim in $CONFIG_FILE"
fi
