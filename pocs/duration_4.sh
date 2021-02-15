#!/usr/bin/env bash
if [ $(find *.mp3 2>/dev/null | wc -l) -eq 0 ]; then
  echo "No mp3 files found in this folder"
  exit 1
fi
echo "00:00:00.000 Chapter 1"
i=2
total_millis=0
for mp3 in *.mp3; do
  duration=$(ffprobe -v quiet -show_entries format=duration "${mp3}" | sed -n 's/duration=//p')
  millisecs=$((${duration%.*} * 1000 + 10#${duration#*.} / 1000))
  ((total_millis += millisecs))
  hour=$((total_millis / 3600 / 1000))
  mins=$(((total_millis - hour*3600*1000) / 60 / 1000))
  secs=$(((total_millis - hour*3600*1000 - mins*60*1000) / 1000))
  millis=$((total_millis - hour*3600*1000 - mins*60*1000 - secs*1000))
  printf "%02d:%02d:%02d.%03d Chapter %d\n" "$hour" "$mins" "$secs" "$millis" "$i"
  ((i++))
done
