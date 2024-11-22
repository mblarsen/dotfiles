#!/usr/bin/env bash

# set -x

model="gpt-4-turbo"
subject=${1:-""}

read -r -d '' system_prompt <<EOF
Help me generate a succinct git commit message for this change.

A few rules:
- Only output the message, not meta chatter
- Exclude permission changes
- For the commit messages I'd like the subject line to start with the subject
  word I provide and if not provided use the parent folder as the subject. E.g.
  "nvim: change colorscheme" or "wezterm: reduce font size"
- Try to get the change into the subject line of the commit message but not required, 
  you can use the body as well if there are more changes than fits in the subject
- First I'll provide the 'Git Status:' and after 'Git Diff:' section for you to base the message upon
- Finally add the message: Commit message by OpenAI ($model)
  after three hyphens and a linebreak
EOF

git_status=$(yadm status ~/.config/$subject)
git_diff=$(yadm diff --no-ext-diff ~/.config/$subject)

prompt="
Instructions:
---------------------
$system_prompt

Git Status:
---------------------
$git_status

Git Diff:
---------------------
$git_diff"

escaped_prompt=$(printf '%s' "$prompt" | jq -Rsa .)

response=$(curl -s -X POST https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "'"$model"'",
    "messages": [{"role": "user", "content": '"$escaped_prompt"'}],
    "max_tokens": 2000
  }')

echo $response | jq -r '.choices[0].message.content'
