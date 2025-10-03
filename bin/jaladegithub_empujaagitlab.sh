#!/bin/sh

git remote remove origin
git remote add origin git@github.com:pasosdeJesus/msip
git pull origin main
git remote remove origin
git remote add origin git@gitlab.com:pasosdeJesus/msip
git push
