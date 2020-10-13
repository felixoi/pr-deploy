#!/bin/bash

cd preview || exit 1
git config user.name "Deploy"
git config user.email "felixoi@users.noreply.github.com"
git remote rm origin
git remote add origin "https://$PA_TOKEN@github.com/felixoi/pr-preview"

if [ -d "$PULL_NUMBER" ]; then
  echo "Updating preview for pull request #$PULL_NUMBER..."
  rm -r ./"$PULL_NUMBER"
  rsync -av --progress ./../deploy ./"$PULL_NUMBER" --exclude .git
else
  echo "Creating preview for pull request #$PULL_NUMBER..."
  rsync -av --progress ./../deploy ./"$PULL_NUMBER" --exclude .git
fi

git add -A
git commit -m "Deploy $(date)"
git push origin gh-pages

# instead we randomly succeed or fail the deployment
exit $(( $RANDOM % 10 >= 5 ))
