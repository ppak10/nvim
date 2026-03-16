# nvim
Neovim configs

## Getting Started

Clone this repo to `~/.config/nvim` and run the setup script:

```bash
git clone https://github.com/ppak10/nvim.git ~/.config/nvim
cd ~/.config/nvim && ./setup.sh
```

The script will:
- Install [Homebrew](https://brew.sh/) (if not present)
- Install Neovim via brew
- Install [ripgrep](https://github.com/BurntSushi/ripgrep) via brew
- Install [tmux](https://github.com/tmux/tmux) via brew and copy `tmux.conf` to `~/.tmux.conf`
- Install [lazygit](https://github.com/jesseduffield/lazygit) via brew
- Add `alias vi='nvim'` and set `EDITOR`/`VISUAL` to your shell config
- Register nvim as the system default editor via `update-alternatives` (Linux)

After setup, run `source ~/.bashrc` (or `~/.zshrc`) or open a new terminal.
