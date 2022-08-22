#!/usr/bin/env python

import sys, os, re, subprocess

commit_msg_filepath = sys.argv[1]
local_branch_name = subprocess.check_output("git rev-parse --abbrev-ref HEAD 2>/dev/null", shell=True).decode("utf-8")
ticket_prefix = re.findall("DND-[0-9]+", local_branch_name)[0]

print(f'filepath: {commit_msg_filepath}')

with open(commit_msg_filepath, 'r+') as f:
  original_commit_message = f.read()
  if ticket_prefix:
    jira_snippet = f'\n**JIRA**\n* [{ticket_prefix}](https://ian-kirkpatrick.atlassian.net/browse/{ticket_prefix})'

    if original_commit_message.startswith(ticket_prefix):
      original_commit_message = original_commit_message[len(ticket_prefix):]

    description = f'\n**Description**\n{original_commit_message if original_commit_message else "TODO: description"}'

    f.write(f'{ticket_prefix}: {original_commit_message}\n{jira_snippet}\n{description}\n')
