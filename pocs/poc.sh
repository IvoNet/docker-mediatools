#!/usr/bin/env bash


rm -f "tmp/wrap_MP3WRAP.mp3"
i=1
for mp3 in *.mp3
do
  if [ $i -eq 1  ]; then
    WRAP="$mp3"
    duration=$(ffmpeg -i "$mp3" -f null -v quiet -stats - 2>&1|tail -n 2|awk '{print $6}'|sed 's/time=//g')
  elif [ $i -eq 2  ]; then
     mp3wrap tmp/wrap_MP3WRAP.mp3 "$WRAP" "$mp3" >/dev/null 2>&1
     unset WRAP
     duration=$(ffmpeg -i "tmp/wrap_MP3WRAP.mp3" -f null -v quiet -stats - 2>&1|tail -n 2|awk '{print $6}'|sed 's/time=//g')

  else
     mp3wrap -a tmp/wrap_MP3WRAP.mp3 "$mp3" >/dev/null 2>&1
     duration=$(ffmpeg -i "tmp/wrap_MP3WRAP.mp3" -f null -v quiet -stats - 2>&1|tail -n 2|awk '{print $6}'|sed 's/time=//g')
  fi
  echo "$duration chapter $i"
  mp3info -p "%S\n" "$mp3"
  mp3info -p "%S\n" tmp/wrap_MP3WRAP.mp3
  i=$((i+1))
done

#rename 's/\d+/sprintf("%04d", $&)/e' *.mp3
