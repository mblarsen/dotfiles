#!/usr/bin/env bash


cd "$(dirname "$0")"

subjects=(aerospace nvim wezterm yadm zsh)

for subject in "${subjects[@]}"; do
  commit_message=$(./commit_diff.sh "$subject")
  if [ -z "$commit_message" ]; then
    echo "No changes for $subject"
  else
    set -x
    echo "Committing changes for $subject"
    yadm add ~/.config/$subject
    yadm commit -m "$commit_message"
    set +x
  fi
done

echo "Pushing commits"

yadm push

# cd "$(dirname "$0")"
# 
# commit_message=$(./commit_diff.sh aerospace)
# yadm add ~/.config/aerospace
# yadm commit -m "$commit_message"
# 
# commit_message=$(./commit_diff.sh nvim)
# yadm add ~/.config/nvim
# yadm commit -m "$commit_message"
# 
# commit_message=$(./commit_diff.sh wezterm)
# yadm add ~/.config/wezterm
# yadm commit -m "$commit_message"
# 
# commit_message=$(./commit_diff.sh yadm)
# yadm add ~/.config/yadm
# yadm commit -m "$commit_message"
# 
# commit_message=$(./commit_diff.sh zsh)
# yadm add ~/.config/zsh
# yadm commit -m "$commit_message"
