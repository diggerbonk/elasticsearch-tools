curl -s -X POST "localhost:9200/_reindex?pretty" -H "Content-Type: application/json" -d "{
\"source\": {
    \"index\": \"${1}\"
},
\"dest\": {
    \"index\": \"${2}\"
}
}"
echo
