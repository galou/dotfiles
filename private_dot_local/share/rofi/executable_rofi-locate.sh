#!/bin/bash
if [ -z $@ ]; then
  locate $HOME | grep -v '/\.'
else
  FILE=$@

  coproc xdg-open "$FILE" & > /dev/null 2>&1
fi

