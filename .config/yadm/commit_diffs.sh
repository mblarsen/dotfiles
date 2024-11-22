#!/usr/bin/env bash

# set -x

cd "$(dirname "$0")"

commit_message=$(./commit_diff.sh aerospace)
yadm add ~/.config/aerospace
yadm commit -m "$commit_message"

commit_message=$(./commit_diff.sh nvim)
yadm add ~/.config/nvim
yadm commit -m "$commit_message"

commit_message=$(./commit_diff.sh wezterm)
yadm add ~/.config/wezterm
yadm commit -m "$commit_message"

commit_message=$(./commit_diff.sh yadm)
yadm add ~/.config/yadm
yadm commit -m "$commit_message"

commit_message=$(./commit_diff.sh zsh)
yadm add ~/.config/zsh
yadm commit -m "$commit_message"
