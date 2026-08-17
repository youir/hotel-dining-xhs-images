#!/usr/bin/env bash
set -euo pipefail

[[ $# -eq 1 ]] || { echo "Usage: audit_delivery.sh DIRECTORY" >&2; exit 2; }
directory=$1
[[ -d "$directory" ]] || { echo "Directory not found: $directory" >&2; exit 3; }
command -v ffprobe >/dev/null || { echo "ffprobe is required" >&2; exit 4; }

count=0
bad=0
while IFS= read -r -d '' file; do
  count=$((count + 1))
  dims=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$file")
  name=$(basename "$file")
  status=PASS
  if [[ "$dims" != "1080x1440" ]]; then
    status=BAD_DIMENSIONS
    bad=$((bad + 1))
  fi
  if [[ "$name" == *"_raw_"* || "$name" == *"_cleanqa"* ]]; then
    status="${status}+NONFINAL_NAME"
    bad=$((bad + 1))
  fi
  hash=$(shasum -a 256 "$file" | awk '{print $1}')
  printf '%s\t%s\t%s\t%s\n' "$status" "$dims" "$hash" "$name"
done < <(find "$directory" -maxdepth 1 -type f -iname '*.png' -print0 | sort -z)

echo "checked=$count technical_failures=$bad"
echo "VISUAL_QA_REQUIRED=venue,exposure,people,hands,props,text,logo,watermark,corners"
(( count > 0 )) || exit 5
(( bad == 0 )) || exit 6
