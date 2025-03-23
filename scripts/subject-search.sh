curl -X POST "localhost:9200/usenet-groups/_doc/_search?pretty" -H "Content-Type: application/json" -d "{
\"query\": {
    \"wildcard\": {
       \"name\": {
          \"value\": \"*\"
       }
    }
}
}"
