#!/bin/sh
# Actualiza varios sistemas que usan msip. Dominio público. 2016
# Podria ejecutar con
# SALTAMSIP=1 SALTASIP=1 SALTAMSIPD=1 
# SALTAJN316=1 SALTAMR519=1 SALTAHEB412=1 
# SALTACOR1440=1 SALTASAL7711=1 
# SALTASIVEL2GEN=1 SALTAAPO214=1 SALTASIVEL2=1 
# SALTASIADDHH=1 SALTASIBDHN=1
# SALTASIASOM=1 SALTAJOS19=1 SALTASIFASOL=1 
# SALTASIVELSJR=1 SALTAMIND=1 

if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add
fi

function actuno {
  a=$1
  b=$2
  if (test ! -d "$a") then {
    echo "actuno: Primer parametro debería ser directorio de ap (era $a)"
    exit 1;
  } fi;
  acdir=`pwd`
  cd $a
  echo "=== actuno: $a $b"
  branch=`git branch | grep "^*" | sed -e  "s/^* //g"` 
  git pull origin $branch
  if (test "$?" != 0) then {
    exit 1;
  } fi;
  rer=`bundle config get path | grep ":" | sed -e "s/.*\"\(.*\)\"/\1/g"`
  echo "OJO rer=$rer"
  rubyver=`ruby -v | sed -e "s/^[^ ]* \([0-9].[0-9]\).*/\1/g"`
  echo "OJO rubyver=$rubyver"
  rutapore="$rer/ruby/$rubyver/cache/bundler/git/"
  echo "OJO rutapore=$rutapore"
  if (test -d "$rutapore") then {
    echo "rm -rf $rutapore/*"
    rm -rf $rutapore/*
  } fi;
  bundle update --bundler
  bundle update --conservative
  if (test "$?" != 0) then {
    exit 1;
  } fi;
  bundle install
  if (test "$?" != 0) then {
    exit 1;
  } fi;
  if (test "$b" != "") then {
    (cd $b; CXX=c++ yarn install; bundle exec rake db:migrate)
  } else {
    CXX=c++ yarn install; bundle exec rake db:migrate
  } fi;
  if (test "$?" != 0) then {
    exit 1;
  } fi;
  SINAC=1 SININS=1 MENSCONS="Actualiza" bin/gc.sh
  if (test "$?" != 0) then {
    exit 1;
  } fi;
  cd $acdir
}

if (test "$SALTAMSIP" != "1") then {
  echo "**** msip"
  actuno msip test/dummy
  actuno msip_carto test/dummy
} fi;

if (test "$SALTAMR519" != "1") then {
  echo "**** mr519"
  actuno mr519_gen test/dummy; 
} fi;

if (test "$SALTAHEB412" != "1") then {
  echo "**** heb412"
  actuno heb412_gen test/dummy; 
  actuno heb412 test/dummy; 
} fi;

if (test "$SALTACOR1440" != "1") then {
  echo "**** cor1440"
  actuno cor1440_gen test/dummy; 
  actuno cor1440
  actuno cor1440_pdJ
} fi;

if (test "$SALTASIVEL2GEN" != "1") then {
  echo "**** sivel"
  actuno sivel2_gen test/dummy; 
} fi;

if (test "$SALTASIADDHH" != "1") then {
  actuno siaddhh;
} fi;

if (test "$SALTASIBDHN" != "1") then {
  actuno si_bdhn
} fi;

if (test "$SALTAAPO214" != "1") then {
  echo "**** apo214"
  actuno apo214 test/dummy; 
} fi;

if (test "$SALTASIVEL2" != "1") then {
  echo "**** sivel"
  actuno sivel2; 
} fi;

# Usan 3 o más motores
if (test "$SALTASIASOM" != "1") then {
  actuno si_asom
} fi;

if (test "$SALTAJOS19" != "1") then {
  echo "**** jos19"
  actuno jos19
} fi;

if (test "$SALTASIFASOL" != "1") then {
  actuno si_fasol; 
} fi;

if (test "$SALTAMIND" != "1") then {
  echo "**** mind"
  actuno sivel2_mujeresindigenas;
} fi;
