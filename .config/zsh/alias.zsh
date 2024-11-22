# Conflicts with tool by the same name
unalias gh

# Misc
alias ws="cd $WORKSPACE"
alias vim=nvim
alias love="/Applications/love.app/Contents/MacOS/love"
alias icat="wezterm imgcat"
alias opr="op run --env-file=.env --no-masking"
alias q="op run --account https://my.1password.eu/ -- /opt/homebrew/bin/q"

# Git overrides and additions to zim
alias glg="git log --graph --branches --remotes --pretty=format:\"${_git_log_oneline_format}\""
alias gbd="git delete-branch"
alias glb="git log --all --numstat --oneline | grep '^-' | awk '{ print \$3 }'"
alias glp="git log --pretty=format:\"%C(bold yellow)%h%C(reset) %s%C(auto)%d%C(reset)\""
alias gbr="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | head -n 20 | fzf --height 50% --reverse --header-first --header $'Most recent branches\n▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔' --prompt $'\ue725 ' | xargs git checkout"
alias gri="git rebase --interactive --autosquash --allow-empty"
alias gft="git fetch --tags"
alias gfT="git fetch --tags --force"

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

# Steampipe
alias spq="steampipe query"
alias spd="steampipe dashboard"
alias spi="steampipe plugin install"
alias spI="steampipe plugin list"
alias smi="steampipe mod install"
alias smI="steampipe mod list"

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
