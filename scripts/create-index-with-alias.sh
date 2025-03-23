curl -s -X PUT "localhost:9200/_index_template/usenet-content?pretty" -H 'Content-Type: application/json' -d '{
  "index_patterns": ["usenet-archive-*"],
  "template": {
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "properties": {
      "date":           { "type": "date" },
      "month":          { "type": "integer" },
      "dayofmonth":     { "type": "integer" },
      /* allow full text and keyword aggregation for author and group fields */
      "author":         { "type": "text", "fields": { "keyword": { "type": "keyword" }}},
      "groups":         { "type": "text", "fields": { "keyword": { "type": "keyword" }}},
      "subject":        { "type": "text" },
      /* original message headers */
      "headers":        { "type": "text", "index": false },
      /* original message body */
      "body":           { "type": "text" },
      "size":           { "type": "integer" },
      "source-archive": { "type": "keyword" },
      "source-section": { "type": "keyword" },
      "source-file":    { "type": "keyword" },
      "references":     { "type": "keyword" },
      "original":       { "type": "text", "index": false }
    }
  },
  "aliases" : {
      "usenet-content": {}
  }
  }
}'

curl -s -X PUT "localhost:9200/usenet-logs?pretty" -H 'Content-Type: application/json' -d '{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "properties": {
      "archive": { "type": "keyword" },
      "section":       { "type": "keyword" },
      "file":       { "type": "keyword" }
    }
  }

}'

curl -s -X PUT "localhost:9200/usenet-logs-errors?pretty" -H 'Content-Type: application/json' -d '{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "properties": {
      "date":       { "type": "date" },
      "archive": { "type": "keyword" },
      "section":       { "type": "keyword" },
      "file":       { "type": "keyword" },
      "error":      { "type": "text" }
    }
  }
}'

curl -s -X PUT "localhost:9200/usenet-groups?pretty" -H 'Content-Type: application/json' -d '{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "properties": {
      "name": { "type": "keyword" }
    }
  }

}'
