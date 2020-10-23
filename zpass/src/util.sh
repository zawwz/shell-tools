#!/bin/sh

error(){
  ret=$1 && shift 1 && echo "$*" >&2 && exit $ret
}

randalnum() {
  tr -cd '[a-zA-Z]' < /dev/urandom | head -c $1
}

# $* = input
escape_chars() {
  echo "$*" | sed 's|\.|\\\.|g;s|/|\\/|g'
}

# $@ = paths
sanitize_paths()
{
  for N
  do
    echo "$N" | grep "^/" && echo "Path cannot start with /" >&2 && return 1
    echo "$N" | grep -w ".." && echo "Path cannot contain .." >&2 && return 1
  done
  return 0
}

# $1 = file
getpath() {
  if [ -n "$REMOTE_ADDR" ]
  then echo "$REMOTE_PORT:$REMOTE_ADDR:$file"
  else readlink -f "$file"
  fi
}

# $1 = file
filehash(){
  getpath "$file" | md5sum | cut -d' ' -f1
}

keyfile(){
  printf "%s.key" "$(filehash)"
}

# $1 = delay in sec
clipboard_clear() {
  if [ -n "$1" ]
  then
    for I in $(screen -ls | grep "$fname"_clipboard | awk '{print $1}')
    do
      screen -S "$I" -X stuff "^C"
    done
    screen -dmS "$fname"_clipboard sh -c "sleep $1 ; xclip -selection clipboard < /dev/null ; sleep 1" # put empty string into clipboard
  else
    xclip -selection clipboard < /dev/null
  fi
}