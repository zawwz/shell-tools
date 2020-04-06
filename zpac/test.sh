#!/bin/sh

VAR=""
_date()
{
  if [ -z "$VAR" ]
  then
    VAR=$(date)
    echo "date" >&2
  fi
  echo $VAR
}

_date
_date
