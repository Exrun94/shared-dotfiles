# Public Dotfiles

My Personal configuration files for a modern development environment.

## Quick Setup

1. Install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. Install dependencies listed in `Brewfile` with `brew bundle install`

#### `Brewfile`

- **Location:** $HOME/Brewfile
- **What it does:** Installs all development tools and applications

#### `.zshrc`

- **Location:** `~/.zshrc`
- **Dependencies:** zinit, starship, fzf, zoxide, nvm
- **What it does:** Configures Zsh with syntax highlighting, autosuggestions, fuzzy tab completion, and auto-starts tmux

#### `.bash_aliases`

- **Location:** `~/.bash_aliases`
- **Dependencies:** eza, bat, nvim, docker, git, btm
- **What it does:** Common command aliases for faster terminal navigation and git workflow

### Development Tools

#### `.gitconfig`

- **Location:** `~/.gitconfig`
- **Dependencies:** nvim, git-delta
- **What it does:** Git configuration with custom aliases, delta integration, and nvim as merge tool

### Application Configs

#### `nvim/`

- **Location:** `~/.config/nvim/`
- **Dependencies:** Neovim 0.8+

#### `ghostty/config`

- **Location:** `~/.config/ghostty/config`
- **Dependencies:** Ghostty terminal

#### `tmux/tmux.conf`

- **Location:** `~/.tmux.conf`
- **Dependencies:** tmux

#### `lazygit/config.yml`

- **Location:** `~/.config/lazygit/config.yml`
- **Dependencies:** lazygit
- **What it does:** Git TUI configuration

#### `starship/active-config.toml`

- **Location:** `~/.config/starship.toml`
- **Dependencies:** starship
- **What it does:** Custom shell prompt configuration
