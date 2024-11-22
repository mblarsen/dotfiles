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
export TASKRC=~/.config/taskwarrior/taskrc

export SPACESHIP_PROMPT_ORDER=(
  #time          # Time stamps section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)

  docker        # Docker section
  docker_compose
  golang
  lua
  node          # Node.js section
  python
  venv          # virtualenv section

  exec_time     # Execution time
  battery       # Battery level and status
  sudo
  exit_code     # Exit code section
  char          # Prompt character
)

export SPACESHIP_DIR_TRUNC_REPO=true
export SPACESHIP_RPROMPT_ADD_NEWLINE=true
export SPACESHIP_TIME_SHOW=true

export SPACESHIP_BATTERY_THRESHOLD=50
export SPACESHIP_CHAR_SUFFIX=" "
export SPACESHIP_CHAR_SYMBOL="§"
export SPACESHIP_EXEC_TIME_PREFIX=""
export SPACESHIP_GIT_PREFIX=""
export SPACESHIP_GIT_STATUS_SHOW=false

zstyle ':zim:git' aliases-prefix 'g'
zstyle ':zim' input_mode='vi'
