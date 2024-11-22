#!/usr/bin/env bash

cd "$(dirname "$0")"

subjects=(aerospace nvim wezterm yadm zsh)

for subject in "${subjects[@]}"; do
  commit_message=$(./commit_diff.sh "$subject")
  if [ -z "$commit_message" ]; then
    echo "No changes for $subject"
  else
    echo "Committing changes for $subject"
    yadm add ~/.config/$subject
    yadm commit -m "$commit_message"
  fi
done

echo "Pushing commits"

yadm push
