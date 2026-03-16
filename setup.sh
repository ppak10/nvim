#!/bin/bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC}  $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

REPO_URL="https://github.com/ppak10/nvim.git"
NVIM_CONFIG="$HOME/.config/nvim"

# Detect shell config file
if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
    CONFIG_FILE="$HOME/.zshrc"
else
    CONFIG_FILE="$HOME/.bashrc"
fi

# ---------------------------------------------------------------------------
# Homebrew
# ---------------------------------------------------------------------------
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Source brew for the current session (path varies by OS / architecture)
if ! command -v brew &>/dev/null; then
    if [ -d "/opt/homebrew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"          # macOS Apple Silicon
    elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"  # Linux
    fi
fi

if command -v brew &>/dev/null; then
    info "Homebrew ready: $(brew --version | head -1)"
else
    error "Homebrew not found after install — please add it to PATH and re-run"
fi

# Ensure brew shellenv is in the shell config for new terminals
if [ -d "/opt/homebrew" ]; then
    BREW_SHELLENV='eval "$(/opt/homebrew/bin/brew shellenv)"'
elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
    BREW_SHELLENV='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
else
    BREW_SHELLENV=""
fi

if [ -n "$BREW_SHELLENV" ] && ! grep -q "brew shellenv" "$CONFIG_FILE" 2>/dev/null; then
    printf '\n%s\n' "$BREW_SHELLENV" >> "$CONFIG_FILE"
    info "Added brew shellenv to $CONFIG_FILE"
fi

# ---------------------------------------------------------------------------
# Neovim
# ---------------------------------------------------------------------------
if ! command -v nvim &>/dev/null; then
    info "Installing Neovim..."
    brew install neovim
else
    info "Neovim already installed: $(nvim --version | head -1)"
fi

# ---------------------------------------------------------------------------
# Dependencies
# ---------------------------------------------------------------------------
if ! command -v rg &>/dev/null; then
    info "Installing ripgrep..."
    brew install ripgrep
else
    info "ripgrep already installed"
fi

if ! command -v tmux &>/dev/null; then
    info "Installing tmux..."
    brew install tmux
else
    info "tmux already installed: $(tmux -V)"
fi

if ! command -v lazygit &>/dev/null; then
    info "Installing lazygit..."
    brew install lazygit
else
    info "lazygit already installed: $(lazygit --version | head -1)"
fi

# ---------------------------------------------------------------------------
# Clone config to ~/.config/nvim (if not already there)
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$SCRIPT_DIR" = "$NVIM_CONFIG" ]; then
    info "Config already at $NVIM_CONFIG"
elif [ -d "$NVIM_CONFIG" ]; then
    warn "~/.config/nvim already exists and is a different directory — skipping clone"
else
    info "Cloning config to $NVIM_CONFIG..."
    git clone "$REPO_URL" "$NVIM_CONFIG"
fi

# ---------------------------------------------------------------------------
# Shell aliases & environment
# ---------------------------------------------------------------------------
if grep -q "alias vi='nvim'" "$CONFIG_FILE" 2>/dev/null; then
    info "vi alias already in $CONFIG_FILE"
else
    echo "alias vi='nvim'" >> "$CONFIG_FILE"
    info "Added vi alias to $CONFIG_FILE"
fi

if grep -q "export EDITOR='nvim'" "$CONFIG_FILE" 2>/dev/null; then
    info "EDITOR already set in $CONFIG_FILE"
else
    printf '\nexport EDITOR="nvim"\nexport VISUAL="nvim"\n' >> "$CONFIG_FILE"
    info "Set EDITOR and VISUAL to nvim in $CONFIG_FILE"
fi

# ---------------------------------------------------------------------------
# tmux config
# ---------------------------------------------------------------------------
TMUX_CONF_SRC="$SCRIPT_DIR/tmux.conf"
TMUX_CONF_DEST="$HOME/.tmux.conf"

if [ -f "$TMUX_CONF_SRC" ]; then
    if [ -f "$TMUX_CONF_DEST" ] && ! diff -q "$TMUX_CONF_SRC" "$TMUX_CONF_DEST" &>/dev/null; then
        warn "~/.tmux.conf already exists and differs — backing up to ~/.tmux.conf.bak"
        cp "$TMUX_CONF_DEST" "$TMUX_CONF_DEST.bak"
        cp "$TMUX_CONF_SRC" "$TMUX_CONF_DEST"
        info "Copied tmux.conf (backup saved)"
    elif [ ! -f "$TMUX_CONF_DEST" ]; then
        cp "$TMUX_CONF_SRC" "$TMUX_CONF_DEST"
        info "Copied tmux.conf to $TMUX_CONF_DEST"
    else
        info "~/.tmux.conf already up to date"
    fi
fi

# ---------------------------------------------------------------------------
# update-alternatives (Linux only)
# ---------------------------------------------------------------------------
NVIM_PATH="$(command -v nvim 2>/dev/null || true)"
if command -v update-alternatives &>/dev/null && [ -n "$NVIM_PATH" ]; then
    info "Setting nvim as system default editor via update-alternatives..."
    sudo update-alternatives --install /usr/bin/editor editor "$NVIM_PATH" 100
else
    warn "update-alternatives not available — skipping system editor registration"
fi

# ---------------------------------------------------------------------------
echo ""
info "Setup complete! Run 'source $CONFIG_FILE' or open a new terminal to apply shell changes."
