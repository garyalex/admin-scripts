#!/usr/bin/python

import requests
import argparse
from pushbullet import Pushbullet

# Setup our arguments
parser = argparse.ArgumentParser()
parser.add_argument("checkurl", help="URL to check", type=str)
parser.add_argument("checktitle", help="Title", type=str)
args = parser.parse_args()

# Set our variables from commandline arguments
checkurl = args.checkurl
checktitle = args.checktitle

# Set our PB api key
api_key = "o.sh1dNn6qfCsi9dsssuzXNVifc3PYx1kz"

# Setup pushbullet client
pb = Pushbullet(api_key)

# Check our URL
r = requests.get(checkurl, )
statCode = r.status_code

if statCode != 200:
    push = pb.push_note(checktitle, "URL: %s\nCode: %s" % (checkurl, statCode))

# DEBUG
# push = pb.push_note(checktitle, "URL: %s\nCode: %s" % (checkurl, statCode))
# print "Status: %s" % statCode
