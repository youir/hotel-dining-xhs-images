#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: normalize_3x4.sh INPUT OUTPUT [center|top|top-left|x:y:w:h]" >&2
  exit 2
}

[[ $# -ge 2 && $# -le 3 ]] || usage
input=$1
output=$2
mode=${3:-center}

[[ -f "$input" ]] || { echo "Input not found: $input" >&2; exit 3; }
[[ ! -e "$output" ]] || { echo "Refusing to overwrite: $output" >&2; exit 4; }
command -v ffprobe >/dev/null || { echo "ffprobe is required" >&2; exit 5; }
command -v ffmpeg >/dev/null || { echo "ffmpeg is required" >&2; exit 5; }

dims=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$input")
IFS=x read -r width height <<< "$dims"
[[ "$width" =~ ^[0-9]+$ && "$height" =~ ^[0-9]+$ ]] || { echo "Could not read dimensions" >&2; exit 6; }

crop_x=0
crop_y=0
crop_w=$width
crop_h=$height

if [[ "$mode" =~ ^([0-9]+):([0-9]+):([0-9]+):([0-9]+)$ ]]; then
  crop_x=${BASH_REMATCH[1]}
  crop_y=${BASH_REMATCH[2]}
  crop_w=${BASH_REMATCH[3]}
  crop_h=${BASH_REMATCH[4]}
else
  case "$mode" in center|top|top-left) ;; *) usage ;; esac
  if (( width * 4 > height * 3 )); then
    crop_w=$((height * 3 / 4))
    crop_h=$height
  elif (( width * 4 < height * 3 )); then
    crop_w=$width
    crop_h=$((width * 4 / 3))
  fi
  case "$mode" in
    center) crop_x=$(((width - crop_w) / 2)); crop_y=$(((height - crop_h) / 2)) ;;
    top) crop_x=$(((width - crop_w) / 2)); crop_y=0 ;;
    top-left) crop_x=0; crop_y=0 ;;
  esac
fi

(( crop_w > 0 && crop_h > 0 )) || { echo "Invalid crop size" >&2; exit 7; }
(( crop_x >= 0 && crop_y >= 0 && crop_x + crop_w <= width && crop_y + crop_h <= height )) || {
  echo "Crop is outside input bounds" >&2
  exit 7
}
(( crop_w * 4 == crop_h * 3 )) || { echo "Crop must be exactly 3:4" >&2; exit 8; }

ffmpeg -v error -n -i "$input" \
  -vf "crop=${crop_w}:${crop_h}:${crop_x}:${crop_y},scale=1080:1440:flags=lanczos,format=rgb24" \
  -map_metadata -1 "$output"

out_dims=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$output")
[[ "$out_dims" == "1080x1440" ]] || { echo "Unexpected output dimensions: $out_dims" >&2; exit 9; }
echo "$output 1080x1440"
