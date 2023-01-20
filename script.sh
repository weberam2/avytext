#!/bin/bash

  if [[ "$1" =~ ^((-{1,2})([Hh]$|[Hh][Ee][Ll][Pp])|)$ ]]; then
    print_usage; exit 1
  else
    while [[ $# -gt 0 ]]; do
      opt="$1"
      shift;
      current_arg="$1"
      if [[ "$current_arg" =~ ^-{1,2}.* ]]; then
        echo "WARNING: You may have left an argument blank. Double check your command."
      fi
      case "$opt" in
        "-a"|"--lat"      ) lat="$1"; shift;;
        "-o"|"--long"     ) long="$1"; shift;;
        *                   ) echo "ERROR: Invalid option: \""$opt"\"" >&2
                              exit 1;;
      esac
    done
  fi

  if [[ "$lat" == "" || "$long" == "" ]]; then
    echo "ERROR: Options -a and -o require arguments." >&2
    exit 1
  fi

echo $lat $long
