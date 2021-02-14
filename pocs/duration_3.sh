#!/usr/bin/env bash
if [ $(find *.mp3 2>/dev/null | wc -l) -eq 0 ]; then
  echo "No mp3 files found in this folder"
  exit 1
fi
echo "Assembling chapter information..."
echo "00:00:00.000 Chapter 1"
i=1
total_secs=0
for mp3 in *.mp3; do
  duration=$(ffprobe -v quiet -show_entries format=duration "${mp3}" | sed -n 's/duration=//p')
  total_secs=$(echo "$total_secs + $duration" | bc)
  CHAPTER_TIME="$(date -d "@$total_secs" -u +%H:%M:%S.%3N)"
  printf "%s Chapter %d\n" ${CHAPTER_TIME} $((++i))
done


