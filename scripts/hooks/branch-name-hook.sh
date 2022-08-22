#!/usr/bin/env bash

LC_ALL=C

LOCAL_BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"

# main is legal
if [[ $LOCAL_BRANCH_NAME == 'main' ]];
then
  exit 0
fi

VALID_BRANCH_REGEX='^(DND)-[0-9]+(-(FEATURE|BUGFIX|ADMIN)([\-]+[a-zA-Z0-9]*)*)*$'
################################################################################
# LEGAL
################################################################################
# DND-1
# DND-123
# DND-123-BUGFIX
# DND-123-BUGFIX-foobar123-321
# DND-123-BUGFIX-----foobar123-321
################################################################################
# ILLEGAL
################################################################################
# DND
# DND-foobar
# DND-123-BUGFIXfoobar <- BUGFIX must be followed by at least one '-'
# DND-123-foobar <- if more than the ticket, must start with FEATURE/BUGFIX/ADMIN

if [[ ! $LOCAL_BRANCH_NAME =~ $VALID_BRANCH_REGEX ]];
then
  printf "\nIllegal branch name: ${LOCAL_BRANCH_NAME}"
  printf "Legal Regex: ${VALID_BRANCH_REGEX}"
  echo "Enforced at: /scripts/hooks/branch-name-hook.sh\n"
else
  printf "Branch name is valid: ${LOCAL_BRANCH_NAME}"
fi

exit 0
