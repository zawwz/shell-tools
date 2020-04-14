#/usr/bin/env bash

_zcsf_completion()
{
  _cw1="make main ls src rm mv clear import export rclean"
  _cw1_ls="rm mv export"
  _make_types="c cpp"
  _src_types="auto f fpp c cpp h cpp"

  if [ "$COMP_CWORD" = "1" ] ; then # operations
    _compwords=$_cw1
  elif [ "$COMP_CWORD" -gt "1" ] && echo "$_cw1_ls" | grep -qw "${COMP_WORDS[1]}" ; then # src files
    _compwords=$(zcsf ls 2>/dev/null)
  elif [ "$COMP_CWORD" = "2" ] && [ "${COMP_WORDS[1]}" = "make" ] ; then # make type
    _compwords=$_make_types
  elif [ "$COMP_CWORD" = "2" ] && [ "${COMP_WORDS[1]}" = "src" ] ; then # src type
    _compwords=$_src_types
  else
    _compwords=""
  fi

  COMPREPLY=($(compgen -W "$_compwords" "${COMP_WORDS[$COMP_CWORD]}" 2>/dev/null))
}

complete -F _zcsf_completion -o dirnames zcsf
