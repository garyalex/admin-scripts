#!/usr/bin/python

from Crypto.Cipher import DES3
import base64
import argparse

# Setup our arguments
parser = argparse.ArgumentParser()
parser.add_argument("secret", help="Secret", type=str)
parser.add_argument("password", help="Encrypted password", type=str)
args = parser.parse_args()

# Set our variables from commandline arguments
EEpwd = args.password
secret = args.secret

secret = base64.decodestring(secret)
key = secret[:24]
iv = secret[24:]

# Decoded Encrypted password
DEpwd = base64.decodestring(EEpwd)

# Decoded Decrypted password
DDpwd = DES3.new(key, DES3.MODE_CBC, iv).decrypt(DEpwd)
print "Decoded Decrypted PWD : %s" % DDpwd
