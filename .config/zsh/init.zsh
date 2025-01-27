source "$HOME/.config/zsh/vars.zsh"

zstyle ':zim' input_mode='vi' # hmm, probably not used sinze

# disable automatic init
zstyle ':zim:*' use-compinit false

source "$ZPLUG_HOME/init.zsh"

# https://github.com/zimfw/environment
# Sets sane Zsh built-in environment options.
zplug "zimfw/environment", use:"init.zsh"

# https://github.com/zimfw/git
# Provides handy Git aliases and functions.
zstyle ':zim:git' aliases-prefix 'g'
zplug "zimfw/git", use:"init.zsh"  aliases-prefix 'g'

# https://github.com/zimfw/utility
# Utility aliases and functions.
zplug "zimfw/utility", use:"init.zsh"

from_oh_my_zsh=(
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/direnv
  # This plugin creates the Direnv hook.
  direnv
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
  # This plugin tries to find junegunn's fzf based on where it's been
  # installed, and enables its fuzzy auto-completion and key bindings.
  fzf
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
  # This plugin increase vi-like zsh functionality.
  vi-mode
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gh
  # This plugin adds completion for the GitHub CLI.
  gh
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew
  # The plugin adds several aliases for common brew commands.
  brew
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm
  # This plugin adds autocompletions for nvm — a Node.js version manager. It
  # also automatically sources nvm, so you don't need to do it manually in your
  # .zshrc.
  nvm
)

for plugin in "${from_oh_my_zsh[@]}"; do
  zplug "plugins/${plugin}", from:"oh-my-zsh"
done

# https://github.com/zsh-users/zsh-autosuggestions
zplug "zsh-users/zsh-autosuggestions", use:"zsh-autosuggestions.zsh"

# https://github.com/MichaelAquilina/zsh-you-should-use
zplug "MichaelAquilina/zsh-you-should-use"

# https://github.com/spaceship-prompt/spaceship-prompt
zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

# https://github.com/agkozak/zsh-z
zplug "agkozak/zsh-z"

# goenv
zplug "RiverGlide/zsh-goenv", from:gitlab

if ! zplug check --verbose; then
  zplug install
fi

zplug load

# Wezterm completion
if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
  eval "$(wezterm shell-completion --shell zsh)"; compdef _wezterm wezterm
fi

autoload -Uz compinit && compinit

source "$HOME/.config/zsh/alias.zsh"
