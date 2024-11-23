# .zshrc for interactive shells after .zprofile but before .zlogin

export ZPLUG_HOME=/opt/homebrew/opt/zplug

source "$HOME/.config/zsh/init.zsh"

# nvim (bob)
export PATH="/Users/mbl/.local/share/bob/nvim-bin:$PATH"

# pyenv
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
