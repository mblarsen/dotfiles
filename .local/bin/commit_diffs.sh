#!/usr/bin/env bash

cd "$(dirname "$0")"

subjects=(
  aerospace
  git
  karabiner
  nvim
  taskwarrior
  wezterm
  yadm
  zsh
)

dry_run=false

for arg in "$@"; do
  if [ "$arg" == "--dry-run" ]; then
    dry_run=true
    break
  fi
done

for subject in "${subjects[@]}"; do
  commit_message=$(./commit_diff.sh "$subject")
  if [ -z "$commit_message" ]; then
    echo "No changes for $subject"
  else
    if [ "$dry_run" == true ]; then
      echo "Committing changes for $subject (dry-run)"
      echo "$commit_message"
    else
      echo "Committing changes for $subject"
      echo "$commit_message"
      yadm add ~/.config/$subject
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
