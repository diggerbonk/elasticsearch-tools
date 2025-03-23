#!/bin/bash

index="noindex"
tsnap="nosnapshot"

if [ $# -eq 0 ]; then
    echo "define a snapshot name dummy"
    exit
else
    tsnap=$1
fi

if [ $# -eq 1 ]; then
    echo "define an index dummy"
    exit
else
    index=$2
fi

# Register the repository, if needed

curl -X PUT "localhost:9200/_snapshot/snapshots?verify=false&pretty" -H 'Content-Type: application/json' -d' {
  "type": "fs",
  "settings": {
    "location": "/backup/opensearch-snapshots"
  }
}'

# Delete current snapshot if it exists

curl -X DELETE "localhost:9200/_snapshot/snapshots/${tsnap}?pretty"

# Create the snapshot
curl -X PUT "localhost:9200/_snapshot/snapshots/${tsnap}?wait_for_completion=true&pretty" -H 'Content-Type: application/json' -d' {
  "indices": "'"${index}"'",
  "ignore_unavailable": true,
  "include_global_state": false
}'
