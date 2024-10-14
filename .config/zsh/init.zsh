source "$HOME/.config/zsh/vars.zsh"
source "$HOME/.config/zsh/paths.zsh"

zstyle ':zim' input_mode='vi' # hmm, probably not used sinze

# disable automatic init
zstyle ':zim:*' use-compinit false

source "$ZPLUG_HOME/init.zsh"

# https://github.com/zimfw/completion
# conflict with compinit so disabled for now
# may not need it
# zplug "zimfw/completion", use:"init.zsh"

# https://github.com/zimfw/environment
zplug "zimfw/environment", use:"init.zsh"

# https://github.com/zimfw/git
zstyle ':zim:git' aliases-prefix 'g'
zplug "zimfw/git", use:"init.zsh"  aliases-prefix 'g'

# https://github.com/zimfw/utility
zplug "zimfw/utility", use:"init.zsh"

from_oh_my_zsh=(
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/direnv
  direnv
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
  fzf
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
  vi-mode
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gh
  gh
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew
  brew
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-commit
  git-commit
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm
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

if ! zplug check --verbose; then
  zplug install
fi

zplug load

autoload -Uz compinit && compinit

source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/envs.zsh"
source "$HOME/.config/zsh/tools.zsh"


# export JAVA_HOME=$(/usr/libexec/java_home -v 17)
