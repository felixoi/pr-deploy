#!/bin/bash

cd preview || exit 1
git config user.name "Deploy"
git config user.email "felixoi@users.noreply.github.com"
git remote rm origin
git remote add origin "https://felixoi:$PA_TOKEN@github.com/felixoi/pr-preview"

if [ -d "$PULL_NUMBER" ]; then
  echo "Updating preview for pull request #$PULL_NUMBER..."
  rm -r ./"$PULL_NUMBER"
  cp -r ./../deploy ./"$PULL_NUMBER"
else
  echo "Creating preview for pull request #$PULL_NUMBER..."
  cp -r ./../deploy ./"$PULL_NUMBER"
fi

git add -A
git commit -q -m "Deploy $(date)"
git push -q origin gh-pages

# instead we randomly succeed or fail the deployment
exit $(( $RANDOM % 10 >= 5 ))
