#!/usr/bin/env bash

# Max levels to search upward (from current directory)
MAX_DEPTH=3

# Candidate virtualenv directory names
CANDIDATES=(".venv" "venv")

start_dir="$PWD"
dir="$start_dir"
depth=0
found_venv=""

while [ "$depth" -le "$MAX_DEPTH" ] && [ "$dir" != "/" ]; do
  for name in "${CANDIDATES[@]}"; do
    if [ -f "$dir/$name/bin/activate" ]; then
      found_venv="$dir/$name"
      break 2  # break out of both loops
    fi
  done

  # Go one level up
  dir=$(dirname "$dir")
  depth=$((depth + 1))
done

if [ -z "$found_venv" ]; then
  echo "No Python virtualenv found within $MAX_DEPTH levels up from $start_dir."
  # If sourced, 'return' is valid; if executed, 'exit' is needed.
  if [ "${BASH_SOURCE[0]}" != "$0" ]; then
    return 1
  else
    exit 1
  fi
fi

# If we had to go more than 1 level up, ask before activating
if [ "$depth" -gt 1 ]; then
  echo "Found virtualenv at: $found_venv (depth: $depth levels up)"
  read -r -p "Activate this virtualenv? [y/N] " reply
  case "$reply" in
    y|Y|yes|YES)
      ;;
    *)
      echo "Not activating."
      if [ "${BASH_SOURCE[0]}" != "$0" ]; then
        return 0
      else
        exit 0
      fi
      ;;
  esac
fi

# Activate the virtualenv
# shellcheck disable=SC1090
. "$found_venv/bin/activate"
echo "Activated virtualenv at: $found_venv"

