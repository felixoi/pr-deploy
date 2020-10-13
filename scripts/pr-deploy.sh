#!/bin/bash

cd preview || exit 1
git config user.name "felixoi"
git config user.email "felixoi@users.noreply.github.com"
git remote set-url origin "https://$PA_TOKEN@github.com/felixoi/pr-preview"

if [ -d "$PULL_NUMBER" ]; then
  echo "Updating preview for pull request #$PULL_NUMBER..."
  rm -r ./"$PULL_NUMBER"
  rsync -av --progress ./../deploy/* ./"$PULL_NUMBER"/ --exclude={'.git','.github','scripts'}
else
  echo "Creating preview for pull request #$PULL_NUMBER..."
  rsync -av --progress ./../deploy/* ./"$PULL_NUMBER"/ --exclude={'.git','.github','scripts'}
fi

git add -A
git commit -q -m "Deploy $(date)"
git push -q origin gh-pages

# instead we randomly succeed or fail the deployment
exit $(( $RANDOM % 10 >= 5 ))
