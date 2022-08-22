#!/usr/bin/env bash

# the hook passes the file name with the commit message
COMMIT_MESSAGE="$(cat $1)"

LOCAL_BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

if [ ! -z "$LOCAL_BRANCH_NAME" ] && [ $LOCAL_BRANCH_NAME != "HEAD" ] && [ $LOCAL_BRANCH_NAME != "main" ];
then
  PREFIX_PATTERN='(DND)-[0-9]+'
  [[ $LOCAL_BRANCH_NAME =~ $PREFIX_PATTERN ]]

  PREFIX=${BASH_REMATCH[0]}

  if [[ -n "$PREFIX" ]] && [[ $COMMIT_MESSAGE == "$PREFIX"* ]];
  then
    # already starts with ticket number!
    exit 0
  else
    # does not start with ticket number, add it
    sed -i.bak -e "1s~^~$PREFIX ~" "$1"
  fi
fi
