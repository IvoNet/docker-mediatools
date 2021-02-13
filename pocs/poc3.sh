#!/usr/bin/env bash
TEMP_DIR="./"

cover() {
  if [ "$(ls -1 *.$1 2>/dev/null | wc -l)" != "0" ]; then
    for f in *.$1; do
      echo "File -> $f"
      cp "$f" "${TEMP_DIR}/$f.tmp"
      mv -v "${TEMP_DIR}/$f.tmp" "$(echo $f | tr "[:upper:]" "[:lower:]")"
      cd - &>/dev/null || exit
    done
  fi
}


tester JPG
