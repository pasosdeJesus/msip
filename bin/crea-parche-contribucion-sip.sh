#!/bin/sh

contribucion=$1
if (test "$contribucion" = "") then {
  echo "Falta condensado de contribución"
  exit 1;
} fi;
git --git-dir=../sip/.git format-patch -k -1 --stdout $contribucion
