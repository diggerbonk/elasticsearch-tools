var elasticsearch = require("@opensearch-project/opensearch");

var client = new elasticsearch.Client( {
	node:'http://elastic:changeme@192.168.0.5:9200'
});

module.exports = client;
