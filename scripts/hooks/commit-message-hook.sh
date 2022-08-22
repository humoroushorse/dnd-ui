#!/usr/bin/env bash

LOCAL_BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

if [ ! -z "$LOCAL_BRANCH_NAME" ] && [ $LOCAL_BRANCH_NAME != "HEAD" ] && [ $LOCAL_BRANCH_NAME != "main" ];
then
  PREFIX_PATTERN='(DND)-[0-9]+'
  [[ $LOCAL_BRANCH_NAME =~ $PREFIX_PATTERN ]]

  PREFIX=${BASH_REMATCH[0]}
  
  PREFIX_IN_COMMIT

  sed -i.bak -e "1s~^~$PREFIX ~" ${$1#"$PREFIX"}
fi