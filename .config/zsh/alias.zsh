# Conflicts with tool by the same name
unalias gh

alias -s go="$EDITOR"
alias -s lua="$EDITOR"
alias -s json="jless"
alias -s yaml="bat -l yaml"
alias -s yml="bat -l yaml"
alias -s toml="bat -l toml"
alias -s md="glow"

# Misc
alias ws="cd $WORKSPACE"
alias vim=nvim
alias vimr='vim -c "cd ${git root}"'
alias love="/Applications/love.app/Contents/MacOS/love"
alias icat="wezterm imgcat"
alias opr="op run --env-file=.env --no-masking"
alias q="op run --account https://my.1password.eu/ -- /opt/homebrew/bin/q"
alias bat="bat --theme=1337 --style=full"
alias tm="task-master"

alias tvoc="tv opencode"
alias wm="workmux"

zt() {
  zz $1
  this
  cd -
}

wtx() {
  local name="$1"
  local prompt="${2-}"

  wt switch --no-cd "$name" 2>/dev/null || wt switch --no-cd -c "$name" || return

  local dir
  dir="$(git worktree list --porcelain | awk -v b="refs/heads/$name" '
    $1=="worktree" { wt=$2 }
    $1=="branch" && $2==b { print wt; exit }
  ')"

  [ -n "$dir" ] || return
  [ -f "$dir/mise.toml" ] && (cd "$dir" && mise trust >/dev/null 2>&1 || true)

  if [ -n "$prompt" ]; then
    workmux open "$name" --prompt "$prompt"
  else
    workmux open "$name"
  fi
}

dash() {
  local session_name="dashboard"
  local window_name="workmux-dashboard"
  local pane_target="$session_name:$window_name.0"

  if ! tmux has-session -t "$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name" -n "$window_name" 'workmux dashboard'
  elif ! tmux list-windows -t "$session_name" -F '#{window_name}' | command grep -Fxq "$window_name"; then
    tmux new-window -d -t "$session_name" -n "$window_name" 'workmux dashboard'
  fi

  if [[ "$(tmux display-message -p -t "$pane_target" '#{pane_dead}' 2>/dev/null)" == "1" ]]; then
    tmux respawn-pane -k -t "$pane_target" 'workmux dashboard'
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session_name"
  else
    tmux attach-session -t "$session_name"
  fi
}

this() {
  local session_name="${PWD:t}"
  session_name="${session_name//[^A-Za-z0-9_.-]/_}"
  [[ -n "$session_name" ]] || session_name="default"

  if ! tmux has-session -t "$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name"
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session_name"
  else
    tmux attach-session -t "$session_name"
  fi
}

alias config="tv dotfiles"

# Git overrides and additions to zim
alias glg="git log --graph --branches --remotes --pretty=format:\"${_git_log_oneline_format}\""
alias gbd="git delete-branch"
alias glb="git log --all --numstat --oneline | grep '^-' | awk '{ print \$3 }'"
alias glp="git log --pretty=format:\"%C(bold yellow)%h%C(reset) %s%C(auto)%d%C(reset)\""
alias gbr="tv git-recent-branches"
alias gri="git rebase --interactive --autosquash --allow-empty"
alias gft="git fetch --tags"
alias gfT="git fetch --tags --force"
alias gwt="git ls-files -m -o --exclude-standard | tree --fromfile"

# Yadm
alias y="yadm"
alias yc="yadm commit --verbose"
alias yia="yadm add"
alias yir="yadm reset"
alias yp="yadm push"
alias yco="yadm checkout"
alias ys="yadm status"
alias ywS="yadm status"
alias ylg="yadm log --graph --branches --remotes --pretty=format:\"%C(bold yellow)%h%C(reset) %s%C(auto)%d%C(reset)\""

# package.json
alias pk="cat package.json | jq '.'"
alias pkd="cat package.json | jq '.dependencies'"
alias pkdd="cat package.json | jq '.devDependencies'"
alias pks="cat package.json | jq '.scripts'"

# Docker
alias dodo="docker compose down"
alias dodr="docker compose down --remove-orphans"
alias dodR="docker compose down --rmi all --volumes --remove-orphans"
alias dos="docker compose stop"
alias dou="docker compose up"

# Terraform
alias tg=terragrunt
alias tf=terraform
alias tgautomv="tfautomv -terraform-bin $(which terragrunt)"

# llama.cpp local server
alias llama-start='~/.config/llama.cpp/launch-server.sh'
alias llama-stop='pkill -f "llama-server"'
alias llama-status='pgrep -fl llama-server >/dev/null && echo "🦙 llama-server is running (http://localhost:8080)" || echo "🦙 llama-server is stopped"'
