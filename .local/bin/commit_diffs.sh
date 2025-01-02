#!/usr/bin/env bash

cd "$(dirname "$0")"

configs=(
  "root=~/.config;changes=aerospace"
  "root=~/.config;changes=git"
  "root=~/.config;changes=karabiner"
  "root=~/.config;changes=nvim"
  "root=~/.config;changes=ghostty"
  "root=~/.config;changes=taskwarrior"
  "root=~/.config;changes=wezterm"
  "root=~/.config;changes=yadm"
  "root=~/.config;changes=zsh"
  "root=~/.local/bin;subject=bin;changes=commit_diff.sh commit_diffs.sh"
)

dry_run=false

for arg in "$@"; do
  if [ "$arg" == "--dry-run" ]; then
    dry_run=true
    break
  fi
done

for config in "${configs[@]}"; do
  subject=""
  root=""
  changes=""

  IFS=';' read -r -a pairs <<< "$config"
  for pair in "${pairs[@]}"; do
    IFS='=' read -r key value <<< "$pair"
    # echo "Key: $key, Value: $value"
    case "$key" in
      "subject")
        subject="$value"
        ;;
      "root")
        root=$value
        ;;
      "changes")
        IFS=' ' read -r -a changes <<< "$value"
        ;;
    esac
  done
  
  subject=${subject:-$changes}
  
  echo -n "Checking for changes in '$subject'"
  commit_message=$(./commit_diff.sh "$config")
  if [ -z "$commit_message" ]; then
    echo -e "\r\033[KNo changes for '$subject'"
  else
    echo -e "\r\033[KPreparing commit for '$subject'"
    
    fq_changes=()
    for change in "${changes[@]}"; do
      fq_changes+=("$(eval echo $root/$change)")
    done

    if [ "$dry_run" == true ]; then
      echo "Committing changes for '$subject' (dry-run)"
      echo "${fq_changes[@]}" | xargs -n 1
      echo "$commit_message" | boxes --design ansi-rounded
    else
      echo "Committing changes for '${subject}'"
      echo "${fq_changes[@]}" | xargs -n 1
      echo "$commit_message" | boxes --design ansi-rounded

      yadm add "${fq_changes[@]}" 
      yadm commit -m "$commit_message"
    fi
  fi
done

if [ "$dry_run" == true ]; then
  echo "Pushing commits (dry-run)"
else
  echo "Pushing commits"
  yadm push
fi
