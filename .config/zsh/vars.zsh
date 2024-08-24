export VISUAL="nvim"
export EDITOR="$VISUAL"
export LESS="-R" # will execute color codes

export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

export AUTO_NOTIFY_IGNORE=("docker" "man" "wc" "vim" "sleep" "nvim")
export AUTO_NOTIFY_THRESHOLD=30
export BOB_CONFIG=$HOME/.config/bob/config.toml
export DOCKER_DEFAULT_PLATFORM=linux/amd64  
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export NVIM_APPNAME=nvim
export PYTHON=/opt/homebrew/bin/python3
export STEAMPIPE_INSTALL_DIR=~/.steampipe
export STEAMPIPE_WORKSPACE_CHDIR=~/.steampipe
export WORKSPACE=~/workspace

export SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  # user          # Username section
  dir           # Current directory section
  # host          # Hostname section
  git           # Git section (git_branch + git_status)
  # package       # Package version
  node          # Node.js section
  # ruby          # Ruby section
  # golang        # Go section
  # php           # PHP section
  # rust          # Rust section
  # haskell       # Haskell Stack section
  # julia         # Julia section
  # docker        # Docker section
  # aws           # Amazon Web Services section
  venv          # virtualenv section
  # pyenv         # Pyenv section
  # dotnet        # .NET section
  # kubecontext   # Kubectl context section
  # terraform     # Terraform workspace section
  exec_time     # Execution time
  # line_sep      # Line break
  battery       # Battery level and status
  # vi_mode       # Vi-mode indicator
  # jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

export SPACESHIP_RPROMPT_ADD_NEWLINE=true
# export SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
# export SPACESHIP_TIME_SHOW=true
# export SPACESHIP_DIR_TRUNC_PREFIX="…"
# export SPACESHIP_EXIT_CODE_SHOW=true
export SPACESHIP_VI_MODE_INSERT=I
export SPACESHIP_VI_MODE_NORMAL=N
export SPACESHIP_VI_MODE_COLOR=#303030

export SPACESHIP_BATTERY_THRESHOLD=50
export SPACESHIP_CHAR_SUFFIX=" "
export SPACESHIP_CHAR_SYMBOL="§"
export SPACESHIP_EXEC_TIME_PREFIX=""
export SPACESHIP_GIT_PREFIX=""
export SPACESHIP_GIT_STATUS_SHOW=false

zstyle ':zim:git' aliases-prefix 'g'
zstyle ':zim' input_mode='vi'
