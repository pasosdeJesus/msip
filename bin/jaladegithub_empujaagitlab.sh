#!/bin/sh

branch=`git rev-parse --abbrev-ref HEAD`
echo "branch=$branch"
git remote remove origin
git remote add origin git@github.com:pasosdeJesus/msip
git pull origin $branch
git remote remove origin
git remote add origin git@gitlab.com:pasosdeJesus/msip
git branch --set-upstream-to=origin/$branch $branch
git push
