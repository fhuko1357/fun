#!/usr/bin/env bash

PID="$(pidof app1)"

function hidePid() {
   mount --bind /dev/shm/.pid /proc/$PID
}


while :; do
  case "$1" in
    -h|--help)
      usage
      exit 0
    ;;
    --pid)
      shift
      PID="$1"
      shift
    ;;
    --)
      shift
      break
    ;;
  esac
done


if [[ $(id -u) -ne "0" ]]; then
  echo "" >&2
  exit 1
fi


if [[ -n "$PID" ]]; then
  msg=""

  mkDir && hidePid && \

  for i in $(seq 1 ${#msg}); do
    echo -ne "${msg:i-1:1}"
    sleep 0.06
  done

  exit 1
fi


if [[ $# -lt 1 ]]; then
    usage >&2
    exit 1
fi
