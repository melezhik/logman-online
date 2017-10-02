#!/bin/bash

set -e

url=$(story_var url)

example=$(story_var example)

word=$(config word)

fbname=$(basename "$url")


mkdir -p  ~/longman-online/$word/mp3/
mkdir -p  ~/longman-online/.ready/$word

if test -f ~/longman-online/$word/mp3/$fbname; then
   echo ~/longman-online/$word/mp3/$fbname already downloaded
else
  curl -s -f http://www.ldoceonline.com/$url -o ~/longman-online/$word/mp3/$fbname
  echo download http://www.ldoceonline.com/$url  OK
fi

