#!/bin/bash

tsnap="nosnapshot"

if [ $# -eq 0 ]; then
    echo "define a snapshot name dummy"
    exit
else
    tsnap=$1
fi

curl -X DELETE "localhost:9200/_snapshot/snapshots/${tsnap}?pretty"

