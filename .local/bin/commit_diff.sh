#!/usr/bin/env bash

# set -v
# set -x

cd "$(dirname "$0")"

model="gpt-4-turbo"

subject=""
root=""
changes=""

IFS=';' read -r -a pairs <<< "$1"
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

fq_changes=()
for change in "${changes[@]}"; do
  fq_changes+=("$(eval echo $root/$change)")
done
# echo "Fully qualified changes: ${fq_changes[@]}"

git_status=$(yadm status -- "${fq_changes[@]}")
git_diff=$(yadm diff --no-ext-diff -- "${fq_changes[@]}")

if [ -z "$git_diff" ]; then
    exit 1
fi

read -r -d '' system_prompt <<EOF
Help me generate a succinct git commit message for this change.

A few rules:
- Only output the message, not meta chatter
- Exclude permission changes
- For the commit messages I'd like the subject line to start with the subject
  word I provide and if not provided use the parent folder with .config/ (excludindg .config/) as the subject. E.g.
  "nvim: change colorscheme" or "wezterm: reduce font size"
- If I provide a subject you'll find it at the beginning of the  'Command line arguments' section below.
- Try to get the change into the subject line of the commit message but not required, 
  you can use the body as well if there are more changes than fits in the subject, I like bullet points '-'
- Make sure that there is an empty line between the subject line and the body text
- use lower case for the most part (even first word), but brands and common uppercase or title case words are allowed
- First I'll provide the 'Git Status:' and after 'Git Diff:' section for you to base the message upon
- Try to keep line length in body no longer than 60 characters per line
EOF

prompt="
Instructions:
---------------------
$system_prompt

Command line arguments:
-----------------------
${subject:-${@}}

Git Status:
---------------------
$git_status

Git Diff:
---------------------
$git_diff"

escaped_prompt=$(printf '%s' "$prompt" | jq -Rsa .)

api_key=$(op read $OPENAI_API_KEY)

response=$(op run -- curl -s -X POST https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer $api_key" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "'"$model"'",
    "messages": [{"role": "user", "content": '"$escaped_prompt"'}],
    "max_tokens": 2500
  }')

echo $response | jq -r '.choices[0].message.content'
