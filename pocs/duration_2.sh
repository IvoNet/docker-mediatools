#!/usr/bin/env bash
#echo "00:00:00.000 Chapter 1" >"${TEMP_DIR}/${AUDIOBOOK}.chapters.txt"
echo "00:00:00.000 Chapter 1"
if [ $(find *.mp3 2>/dev/null | wc -l) -eq 0 ]; then
  echo "No mp3 files found in this folder"
  exit 1
fi
i=2
total_seconds=0
total_millis=0
for mp3 in *.mp3; do
  duration=$(ffprobe -v quiet -print_format json -show_format "${mp3}" | jq ".format.duration" | sed 's/"//g')

  millisecs="$(echo $duration | awk -F'.' '{print $2}')"
  millisecs="${millisecs#"${millisecs%%[!0]*}"}"

  total_millis=$((total_millis + millisecs))
  secs=$((total_millis / 1000000))
  total_millis=$((total_millis - (secs * 1000000)))
  total_seconds=$((total_seconds + $(echo ${duration} | awk -F'.' '{print $1}') + secs))

  hours=$((total_seconds / (60 * 60)))
  minutes=$(((total_seconds - (hours * 60 * 60)) / 60))
  seconds=$((total_seconds - (hours * 60 * 60) - (minutes * 60)))

  hours=$(printf "%02d" ${hours})
  minutes=$(printf "%02d" ${minutes})
  seconds=$(printf "%02d" ${seconds})

#  echo "${hours}:${minutes}:${seconds}.${millisecs:0:3} Chapter $i" >>"${TEMP_DIR}/${AUDIOBOOK}.chapters.txt"
  echo "${hours}:${minutes}:${seconds}.${millisecs:0:3} Chapter $i"
  i=$((i + 1))
done
#  cp "${TEMP_DIR}/${AUDIOBOOK}.chapters.txt" "${TARGET_DIR}"
