#!/usr/bin/env sh

i=1
for mp3 in *.mp3
do
  duration=$(ffmpeg -i "$mp3" -f null -v quiet -stats - 2>&1|tail -n 2|awk '{print $6}'|sed 's/time=//g')
  echo "$duration chapter $i"
  i=$((i+1))
done


#rename 's/\d+/sprintf("%04d", $&)/e' *.mp3
