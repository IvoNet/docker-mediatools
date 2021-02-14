#!/usr/bin/env bash

# Goal us to be able to merge more than one type of audio with chapter information
if [ -z "$1" ]; then
    echo "Syntax: $(basename $0) [mp3|m4b|m4a]"
    exit 1
fi

echo "Assembling the audiofiles..."
mkdir "./m4b"
ffmpeg -i "concat:$(find *.$1 | tr '\n' '|' | sed 's/|$//g')" -v quiet -acodec copy "./m4b/merged.m4b"
