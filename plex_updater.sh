#! /bin/bash

set -e

### VARS

PLEX_JSON_URL="https://plex.tv/pms/downloads/5.json"
# Uncomment this and comment  if you're using PLEX PASS
#PLEX_JSON_URL="https://plex.tv/api/downloads/1.json?channel=plexpass"

PLEX_URL=$(curl -s $PLEX_JSON_URL | jq -r '.computer.Linux.releases[] | select(.label=="Ubuntu (16.04+) / Debian (8+) - Intel/AMD 64-bit") | .url')
TMP_DEB=/tmp/plex.deb


### DOWNLOADING PLEX LATEST VERSION

echo "Plex URL: $PLEX_URL"
wget $PLEX_URL -O $TMP_DEB


### Installing (if you're root :D)

if [ `whoami` = root ] 
then
    echo "Installing/Updating..."
    dpkg -i $TMP_DEB
else
    echo "Are you root?"
    echo "To install manually execute: dkpg -i $TMP_DEB"
fi