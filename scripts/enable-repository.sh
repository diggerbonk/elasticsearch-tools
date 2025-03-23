#!/bin/bash

curl -X PUT "localhost:9200/_snapshot/snapshots?verify=false&pretty" -H 'Content-Type: application/json' -d' {
  "type": "fs",
  "settings": {
    "location": "/backup/opensearch-snapshots"
  }
}'

