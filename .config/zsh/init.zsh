source "$HOME/.config/zsh/vars.zsh"
source "$HOME/.config/zsh/paths.zsh"

zstyle ':zim' input_mode='vi' # hmm, probably not used sinze

source "$ZPLUG_HOME/init.zsh"

# https://github.com/zimfw/completion
zplug "zimfw/completion", use:"init.zsh"

# https://github.com/zimfw/environment
zplug "zimfw/environment", use:"init.zsh"

# https://github.com/zimfw/git
zstyle ':zim:git' aliases-prefix 'g'
zplug "zimfw/git", use:"init.zsh"  aliases-prefix 'g'

# https://github.com/zimfw/utility
zplug "zimfw/utility", use:"init.zsh"

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/direnv
zplug "plugins/direnv", from:"oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
zplug "plugins/fzf", from:"oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
zplug "plugins/vi-mode", from:"oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gh
zplug "plugins/gh", from:"oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew
zplug "plugins/brew", from:"oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-commit
zplug "plugins/git-commit", from:"oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm
zplug "plugins/nvm", from:"oh-my-zsh"

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

source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/envs.zsh"
source "$HOME/.config/zsh/tools.zsh"


# export JAVA_HOME=$(/usr/libexec/java_home -v 17)
