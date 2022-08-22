#!/usr/bin/env python

import sys, os, re, subprocess

commit_msg_filepath = sys.argv[1]
local_branch_name = subprocess.check_output("git rev-parse --abbrev-ref HEAD 2>/dev/null", shell=True).decode("utf-8")
ticket_prefix = re.findall("DND-[0-9]+", local_branch_name)[0]

print(f'filepath: {commit_msg_filepath}')

with open(commit_msg_filepath, 'r+') as f:
  content = f.read()
  print(f'content: {content}')
  if ticket_prefix:
    jira_snippet = f'\n**JIRA**\n* [{ticket_prefix}](https://ian-kirkpatrick.atlassian.net/browse/{ticket_prefix})'

    if content.startswith(ticket_prefix):
      content = content[len(ticket_prefix):]

    description = f'\n**Description**\n{content if content else "TODO: description"}'

    print(f'{ticket_prefix}\n{jira_snippet}\n{description}\n')
    f.write(f'{ticket_prefix}\n{jira_snippet}\n{description}\n')
