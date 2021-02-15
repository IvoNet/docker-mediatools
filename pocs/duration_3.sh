#!/usr/bin/env bash
if [ $(find *.mp3 2>/dev/null | wc -l) -eq 0 ]; then
  echo "No mp3 files found in this folder"
  exit 1
fi
echo "00:00:00.000 Chapter 1"
i=2
total_secs=0
for mp3 in *.mp3; do
  duration=$(ffprobe -v quiet -show_entries format=duration "${mp3}" | sed -n 's/duration=//p')
  total_secs=$(echo "$total_secs + $duration" | bc)
  day=$(date -d "@$total_secs" -u +%d)
  hour=$(( 10#$(date -d "@$total_secs" -u +%H) + (10#$day - 1) * 24 ))
  printf "%02d:%s Chapter %d\n" "$hour" "$(date -d "@$total_secs" -u +%M:%S.%3N)" "$((i++))"
done
