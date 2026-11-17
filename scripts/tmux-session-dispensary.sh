#!/bin/bash

DIRS=(
    "$HOME/uni"
    "$HOME/personal"
)

if [[ $# -eq 1 ]]; then
    selected=$1
else
    result=$(fd . "${DIRS[@]}" --type=directory --max-depth=1 --full-path --base-directory "$HOME" \
        | sed "s|^$HOME/||" \
        | sk --print-query --margin 10% --color="bw")

    query=$(echo "$result" | head -n1)
    choice=$(echo "$result" | tail -n1)

    selected="${choice:-$query}"

    [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

if [[ ! -d "$selected" ]]; then
    mkdir -p "$selected"
fi

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t "$selected_name" 2>/dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

tmux switch-client -t "$selected_name"
