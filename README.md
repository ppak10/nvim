# nvim
Neovim configs

## Getting Started
1. Install brew if you haven't done so already.
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
2. Install Neovim
    ```bash
    brew install neovim
    ```
3. Update `.bashrc` with `alias vi="nvim"`
4. Run the following to update default editor to neovim.
    ```bash 
    sudo update-alternatives --install /usr/bin/editor editor /home/linuxbrew/.linuxbrew/bin/nvim 100
    ```

## Dependencies
1. ripgrep
```bash
brew install ripgrep
```

