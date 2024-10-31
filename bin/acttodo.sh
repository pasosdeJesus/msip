#!/bin/sh
# Actualiza varios sistemas que usan msip. Dominio público. 2016
# Podria ejecutar con
# SALTAMSIP=1 SALTAMR519=1 SALTAHEB412=1 
# SALTACOR1440=1 SALTASIVEL2GEN=1 SALTASIVEL2=1 
# SALTASIADDHH=1 SALTASIBDHN=1
# SALTAJOS19=1 SALTASIASOM=1 SALTASIFASOL=1 
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
  actuno msip-2.2 test/dummy
} fi;

if (test "$SALTAMR519" != "1") then {
  echo "**** mr519_gen"
  actuno mr519_gen-2.2 test/dummy; 
} fi;

if (test "$SALTAHEB412" != "1") then {
  echo "**** heb412_gen"
  actuno heb412_gen-2.2 test/dummy; 
} fi;

if (test "$SALTACOR1440" != "1") then {
  echo "**** cor1440_gen"
  actuno cor1440_gen-2.2 test/dummy; 
} fi;

if (test "$SALTASIVEL2GEN" != "1") then {
  echo "**** sivel2_gen"
  actuno sivel2_gen-2.2 test/dummy; 
} fi;

if (test "$SALTASIVEL2" != "1") then {
  echo "**** sivel2"
  actuno sivel2-2.2
} fi;

if (test "$SALTASIADDHH" != "1") then {
  echo "**** siaddhh"
  actuno siaddhh
} fi;

if (test "$SALTASIBDHN" != "1") then {
  echo "**** si_bdhn"
  actuno si_bdhn
} fi;

if (test "$SALTAJOS19" != "1") then {
  echo "**** jos19"
  actuno jos19-2.2
} fi;

if (test "$SALTAMIND" != "1") then {
  echo "**** sivel2_mujeresindigenas"
  actuno sivel2_mujeresindigenas
} fi;

if (test "$SALTASIADDHH" != "1") then {
  echo "**** si_asom"
  actuno si_asom
} fi;

if (test "$SALTASIFASOL" != "1") then {
  echo "**** si_fasol"
  actuno si_fasol
} fi;

if (test "$SALTASIJRSCOL" != "1") then {
  echo "**** si_jrscol"
  actuno si_jrscol
} fi;

