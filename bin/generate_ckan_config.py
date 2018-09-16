#!/usr/bin/env python3
from __future__ import print_function
from os import path
from os import environ
from oauth2client import file, client, tools
from tempfile import mkstemp

SCOPES = 'https://mail.google.com'

credentials_file = environ.get('CREDENTIALS')

if not credentials_file:
    print('missing required env vars')
    exit(1)

if not path.exists(credentials_file):
    print('credentials file does not exist')
    print('follow this guide to create it: https://developers.google.com/gmail/api/quickstart/python')
    exit(1)

_, token_file = mkstemp()

store = file.Storage(token_file)
flow = client.flow_from_clientsecrets(credentials_file, SCOPES)
creds = tools.run_flow(flow, store)

with open(token_file) as f:
    token = f.read()

print('Copy the following to your CKAN configuration:')
print()
print('ckanext.upload_via_email.gmail_token = {}'.format(token))
