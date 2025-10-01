#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "Deploying updates to GitHub...\n"

# make folder for main branch and move it to tmp
cp CNAME public/
cp README.md public/
cp .gitignore public/
TMPDIR=$HOME/GitHub/tests/tmp-deploy-TEST
cp -Rav public/ $TMPDIR/

# switch to main branch
git checkout main
git config pull.rebase false
git pull --force

# replace public folder
rm * -rf
mv $TMPDIR/public/* ./

# add changes in public to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push main branch
git push --all

# switch back to development branch
git checkout development

