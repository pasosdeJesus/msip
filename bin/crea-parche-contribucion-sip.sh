#!/bin/sh

if (test "$DIRO" = "") then {
  export DIRO=sip
} fi;
contribucion=$1
if (test "$contribucion" = "") then {
  echo "Falta condensado de contribución"
  exit 1;
} fi;
git --git-dir=../$DIRO/.git format-patch -k -1 --stdout $contribucion | sed -e "s/sip/msip/g;s/Sip/Msip/g;"
