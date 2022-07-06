#!/usr/bin/env bash

[[ $# -lt 3 ]] && echo "Usage: /path/to/$(basename "$0") <value1> <value2> <value3>" && exit 1

SCR_FULL_PATH=$(realpath "$0")
SCR_FILE_NAME=$(basename "$0")
SCR_RELATIVE_DIR=$(dirname "$0")
SCR_FULL_DIR=$(realpath "$SCR_RELATIVE_DIR")

echo "User: $USER"
echo
echo "Script ==========================================================="
echo "Full path              : $SCR_FULL_PATH"
echo "File name              : $SCR_FILE_NAME"
echo "Relative directory path: $SCR_RELATIVE_DIR"
echo "Absolute directory path: $SCR_FULL_DIR"
echo "=================================================================="
echo
echo "Arg1: $1"
echo "Arg2: $2"
echo "Arg3: $3"
echo

read -r -p "Success? " ANSWER

if [[ "$ANSWER" == "yes" ]]; then
    exit 0
else
    exit 1
fi
