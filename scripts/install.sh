#!/bin/bash

timestamp=$(date +%s)

#
# Install OpenSearch

if [ ! -f opensearch-1.2.4-linux-x64.tar.gz ]; then
    wget https://artifacts.opensearch.org/releases/bundle/opensearch/1.2.4/opensearch-1.2.4-linux-x64.tar.gz
fi

if [ -d opensearch-1.2.4 ]; then
  echo ""
  echo "Will not extract opensearch-1.2.4-linux-x64.tar.gz because directory already exists"
  echo ""
else
  tar xzvf opensearch-1.2.4-linux-x64.tar.gz
  echo "plugins.security.disabled: true" >> opensearch-1.2.4/config/opensearch.yml
  #echo "compatibility.override_main_response_version: true" >> opensearch-1.2.4/config/opensearch.yml
fi


#
# Install OpenSearch Dashboard

if [ ! -f opensearch-dashboards-1.2.0-linux-x64.tar.gz ]; then
    wget https://artifacts.opensearch.org/releases/bundle/opensearch-dashboards/1.2.0/opensearch-dashboards-1.2.0-linux-x64.tar.gz
fi

if [ -d opensearch-dashboards-1.2.0-linux-x64 ]; then
  echo ""
  echo "Will not extract opensearch dashboards because directory already exists"
  echo ""
else
  tar xzvf opensearch-dashboards-1.2.0-linux-x64.tar.gz
./opensearch-dashboards-1.2.0-linux-x64/bin/opensearch-dashboards-plugin remove securityDashboards 
  mv opensearch-dashboards-1.2.0-linux-x64/config/opensearch_dashboards.yml opensearch-dashboards-1.2.0-linux-x64/config/opensearch_dashboards.yml.bak
  grep -v "opensearch_security" opensearch-dashboards-1.2.0-linux-x64/config/opensearch_dashboards.yml.bak | grep -v "https" > opensearch-dashboards-1.2.0-linux-x64/config/opensearch_dashboards.yml
  echo "server.host: \"0.0.0.0\"" >> opensearch-dashboards-1.2.0-linux-x64/config/opensearch_dashboards.yml
  echo "opensearch.hosts: [\"http://localhost:9200\"]" >> opensearch-dashboards-1.2.0-linux-x64/config/opensearch_dashboards.yml
fi
