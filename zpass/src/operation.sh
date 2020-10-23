#!/bin/sh

# $@ = paths
_tree()
{
  if [ $# -gt 0 ]
  then
    fulltree=$(decrypt | tar -tf - 2>/dev/null) || exit $?;

    for N
    do
      [ $# -gt 1 ] && echo "> $N:"
      echo "$fulltree" | grep "^$(escape_chars "$N")" | sed "s|^$N||g ; "' s|^/||g ; /\/$/d ; /^$/d'
    done

  else
    { decrypt | tar -tf - 2>/dev/null || exit $?; } | sed '/\/$/d ; /^$/d'
  fi
}

# $@ = paths
get()
{
  __NOPACK=y archive_exec sh -c '
  for N
  do
    (
      cat "$N" 2>/dev/null && exit 0
      [ -d "$1" ] && cat "$N/default" 2>/dev/null && exit 0
      exit 1
    ) || { echo "$N: not found" >&2 && exit 1; }
  done
  ' sh "$@"
}

# $1 = path
copy()
{
  { get "$1" || return $?; } | tr -d '\n' | xclip -selection clipboard && clipboard_clear "$ZPASS_CLIPBOARD_TIME"
}

# $@ = path
new()
{
  archive_exec sh -c "
    for N
    do
      mkdir -p \"\$(dirname \"\$N\")\" || exit $?
      { tr -cd 'a-zA-Z0-9!-.' < /dev/urandom | head -c '$ZPASS_RAND_LEN' && echo; } > \"\$N\" || exit \$?
    done
  " sh "$@"
}

# $1 = path , $@ = value
_set()
{
  [ $# -lt 1 ] && return 1
  ref=$1
  shift 1
  archive_exec sh -c "mkdir -p '$(dirname "$ref")' && printf '%s\n' '$*' > '$ref'"
}
