#!/usr/bin/env bash

# Checks for changes to your package-log.json file to see if you need to run npm install or not.

function npmDiff {
  git diff --name-only HEAD@{1} HEAD | grep "^$1" > /dev/null 2>&1
}

if npmDiff 'package-lock.json'; then
  echo "❌ 📦 package-lock.json has been updated. Run `npm install` to update your dependencies."
else
  echo "✅ 📦 package-lock.json is up to date, you're good to go!"
fi
