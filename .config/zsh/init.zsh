source "$HOME/.config/zsh/vars.zsh"

[[ -n "$XDG_CACHE_HOME" ]] || XDG_CACHE_HOME="$HOME/.cache"
ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
[[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p "$ZSH_CACHE_DIR"

# Initialize zi
source "${ZDOTDIR:-$HOME}/.zi/zi.zsh"

export FZF_COMPLETION_TRIGGER='**'

# Environment
zi light zimfw/environment

# Git aliases
zi light zimfw/git

# Utility aliases
zi light zimfw/utility

# Oh My Zsh plugins (Consolidated)
# Load all desired OMZ plugins under a single call for efficiency.
zi ice pick"lib/history.zsh" \
       pick"plugins/fzf/fzf.plugin.zsh" \
       pick"plugins/gh/gh.plugin.zsh"
zi light ohmyzsh/ohmyzsh

# vi mode (jeffreytse)
# zi light jeffreytse/zsh-vi-mode
# built-in vi mode
autoload -Uz edit-command-line
zle -N edit-command-line

bindkey -v
bindkey -M vicmd "^V" edit-command-line
export KEYTIMEOUT=1 # 0.01s


# Zoxide
if command -v zoxide >/dev/null; then
  _zoxide_init() {
    setopt local_options nonomatch
    eval "$(zoxide init zsh --no-cmd)"
  }
  _zoxide_init
  unset -f _zoxide_init
  if (( ${+functions[__zoxide_z]} )); then
    z() { __zoxide_z "$@"; }
  fi
  if (( ${+functions[__zoxide_zi]} )); then
    zz() { __zoxide_zi "$@"; }
  fi
fi

# Other plugins
zi light zsh-users/zsh-autosuggestions
zi light MichaelAquilina/zsh-you-should-use

# oc_sessions as ocs
zi ice as"program" id-as"ocs" pick"ocs" cp"oc_sessions -> ocs"
zi snippet https://github.com/bashtools/oc_session/blob/main/oc_sessions

# Theme
# Load the theme LAST, after all prompt-modifying plugins (like vi-mode)
# are sourced and their functions are available.
zi light spaceship-prompt/spaceship-prompt

# direnv hook (ensure active even if OMZ plugin isn't)
if command -v direnv >/dev/null; then
  unfunction _direnv_hook 2>/dev/null || true
  eval "$(command direnv hook zsh)"
  eval "$(command direnv export zsh)"
fi

# fzf completions + keybindings (Homebrew)
if [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

# Wezterm completion
if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
  eval "$(wezterm shell-completion --shell zsh)"; compdef _wezterm wezterm
fi

# Local completions
if [[ -d "$HOME/.config/zsh/completions" ]]; then
  fpath=("$HOME/.config/zsh/completions" $fpath)
fi

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE_DIR"
autoload -Uz compinit && compinit -d "$ZSH_CACHE_DIR/zcompdump"

# Keybindings
bindkey -M viins '^E' end-of-line

source "$HOME/.config/zsh/alias.zsh"
