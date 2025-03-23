curl -s -X DELETE "localhost:9200/usenet-archive*?pretty"
curl -s -X DELETE "localhost:9200/usenet-logs?pretty"
curl -s -X DELETE "localhost:9200/usenet-groups?pretty"
curl -s -X DELETE "localhost:9200/usenet-logs-errors?pretty"

# delete templates
curl -s -X DELETE "localhost:9200/_index_template/usenet-content"
