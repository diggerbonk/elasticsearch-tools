curl -s -X POST "localhost:9200/usenet-content/_doc/_search?pretty" -H "Content-Type: application/json" -d "{
\"query\": {
    \"wildcard\": {
       \"author\": {
          \"value\": \"*${1}*\"
       }
    }
}
}"
