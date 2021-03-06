if [ -z "$1" ]; then
    echo "Syntax: $(basename $0) [mp3|m4b|m4a]"
    exit 1
fi

echo "00:00:00.000 Chapter 1"
i=2
total_seconds=0
total_millis=0
for audio_file in *.$1; do
  duration=$(ffprobe -v quiet -print_format json -show_format "${audio_file}" | jq ".format.duration"|sed 's/"//g')
  millisecs="$(echo $duration | awk -F'.' '{print $2}')"
  millisecs="${millisecs#"${millisecs%%[!0]*}"}"
  total_millis=$((total_millis + millisecs))
  secs=$((total_millis / 1000000))
  total_millis=$((total_millis - (secs * 1000000)))
  total_seconds=$((total_seconds + $(echo $duration | awk -F'.' '{print $1}') + secs))
  hour=$((total_seconds / (60 * 60)))
  minutes=$(((total_seconds - (hour * 60 * 60)) / 60))
  seconds=$((total_seconds - (hour * 60 * 60) - (minutes * 60)))
  hour=$(printf "%02d" $hour)
  minutes=$(printf "%02d" $minutes)
  seconds=$(printf "%02d" $seconds)
  echo "$hour:$minutes:$seconds.${millisecs:0:3} Chapter $i"
  i=$((i + 1))
done
