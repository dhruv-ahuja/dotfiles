#!/usr/bin/env bash
# =============================================================================
# bootstrap.sh — One-shot setup for zsh dotfiles
# Supports: macOS (Homebrew) and Linux (apt/pacman)
# =============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

info()    { echo -e "${CYAN}[•] $1${RESET}"; }
success() { echo -e "${GREEN}[✓] $1${RESET}"; }
warn()    { echo -e "${YELLOW}[!] $1${RESET}"; }
die()     { echo -e "${RED}[✗] $1${RESET}"; exit 1; }

# ── Detect OS ─────────────────────────────────────────────────────────────────

OS="$(uname -s)"
case "$OS" in
  Darwin) PLATFORM="macos" ;;
  Linux)  PLATFORM="linux" ;;
  *)      die "Unsupported OS: $OS" ;;
esac

info "Detected platform: $PLATFORM"

# ── Detect Linux package manager ──────────────────────────────────────────────

pkg_install() {
  if [[ "$PLATFORM" == "macos" ]]; then
    brew install "$@"
  elif command -v apt-get &>/dev/null; then
    sudo apt-get install -y "$@"
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm "$@"
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y "$@"
  else
    warn "No supported package manager found (apt, pacman, dnf). Skipping: $*"
  fi
}

# ── 1. Homebrew (macOS only) ───────────────────────────────────────────────────

if [[ "$PLATFORM" == "macos" ]]; then
  if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success "Homebrew installed"
  else
    success "Homebrew already installed"
  fi
fi

# ── 2. Zsh ────────────────────────────────────────────────────────────────────

if ! command -v zsh &>/dev/null; then
  info "Installing zsh..."
  pkg_install zsh
  success "zsh installed"
else
  success "zsh already installed"
fi

# ── 3. Oh My Zsh ──────────────────────────────────────────────────────────────

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  info "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  success "Oh My Zsh installed"
else
  success "Oh My Zsh already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ── 4. System packages ────────────────────────────────────────────────────────

info "Installing system packages (fzf, autojump)..."

if [[ "$PLATFORM" == "macos" ]]; then
  brew install fzf autojump defaultbrowser
else
  # fzf
  if ! command -v fzf &>/dev/null; then
    pkg_install fzf
  fi
  # autojump — package name differs by distro
  if ! command -v autojump &>/dev/null && ! command -v j &>/dev/null; then
    if command -v apt-get &>/dev/null; then
      sudo apt-get install -y autojump
    elif command -v pacman &>/dev/null; then
      sudo pacman -S --noconfirm autojump
    elif command -v dnf &>/dev/null; then
      sudo dnf install -y autojump
    else
      warn "Could not install autojump — install it manually for your distro"
    fi
  fi
fi

success "System packages ready"

# ── 5. jovial theme ───────────────────────────────────────────────────────────

JOVIAL_DIR="$ZSH_CUSTOM/themes/jovial"

if [[ ! -d "$JOVIAL_DIR" ]]; then
  info "Installing jovial theme..."
  git clone --depth=1 https://github.com/zthxxx/jovial "$JOVIAL_DIR"
  success "jovial theme installed"
else
  success "jovial theme already installed"
fi

# Theme symlink for OMZ
if [[ ! -f "$ZSH_CUSTOM/themes/jovial.zsh-theme" ]]; then
  ln -sf "$JOVIAL_DIR/jovial.zsh-theme" "$ZSH_CUSTOM/themes/jovial.zsh-theme"
fi

# Plugin symlink — jovial also registers as a plugin
JOVIAL_PLUGIN_DIR="$ZSH_CUSTOM/plugins/jovial"
if [[ ! -d "$JOVIAL_PLUGIN_DIR" ]]; then
  mkdir -p "$JOVIAL_PLUGIN_DIR"
  ln -sf "$JOVIAL_DIR/jovial.plugin.zsh" "$JOVIAL_PLUGIN_DIR/jovial.plugin.zsh"
fi

# ── 6. zsh plugins ────────────────────────────────────────────────────────────

clone_plugin() {
  local name="$1"
  local repo="$2"
  local dest="$ZSH_CUSTOM/plugins/$name"
  if [[ ! -d "$dest" ]]; then
    info "Installing plugin: $name..."
    git clone --depth=1 "$repo" "$dest"
    success "$name installed"
  else
    success "$name already installed"
  fi
}

clone_plugin zsh-autosuggestions       https://github.com/zsh-users/zsh-autosuggestions
clone_plugin zsh-syntax-highlighting   https://github.com/zsh-users/zsh-syntax-highlighting
clone_plugin zsh-history-enquirer      https://github.com/zthxxx/zsh-history-enquirer
clone_plugin zsh-completions           https://github.com/zsh-users/zsh-completions

# ── 7. nvm (Node Version Manager) ────────────────────────────────────────────

if [[ ! -d "$HOME/.nvm" ]]; then
  info "Installing nvm..."
  NVM_VERSION="$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')"
  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash
  success "nvm installed"
else
  success "nvm already installed"
fi

# ── 8. uv (Python package manager) ───────────────────────────────────────────

if ! command -v uv &>/dev/null; then
  info "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  success "uv installed"
else
  success "uv already installed"
fi

# ── 9. macOS-only: llvm & postgresql@15 ──────────────────────────────────────

# if [[ "$PLATFORM" == "macos" ]]; then
#   info "Installing macOS-specific packages (llvm, postgresql@15)..."
#   brew install llvm postgresql@15
#   success "llvm and postgresql@15 installed"
# fi

# ── 10. Pre-generate shell completions into ~/.zfunc ─────────────────────────

mkdir -p "$HOME/.zfunc"

if command -v kubectl &>/dev/null; then
  info "Generating kubectl completion..."
  kubectl completion zsh > "$HOME/.zfunc/_kubectl"
  success "kubectl completion cached"
fi

if command -v uv &>/dev/null; then
  info "Generating uv completion..."
  uv generate-shell-completion zsh > "$HOME/.zfunc/_uv"
  success "uv completion cached"
fi

# ── Done ──────────────────────────────────────────────────────────────────────

echo ""
echo -e "${BOLD}${GREEN}✅  Bootstrap complete!${RESET}"
echo ""
echo -e "Next steps:"
echo -e "  1. Symlink your .zshrc:  ${CYAN}ln -sf \$(pwd)/zsh/.zshrc ~/.zshrc${RESET}"
echo -e "  2. Reload your shell:    ${CYAN}exec zsh${RESET}"
echo ""
