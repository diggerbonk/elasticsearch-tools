import subprocess
import sys
import json
import re

def execute_bash(parameters):
    try:
        return subprocess.check_output(parameters)
    except Exception as e:
       print(e)

repositories = execute_bash(['curl', '-s', '-X', 'GET', 'localhost:9200/_cat/repositories?pretty']).decode("utf-8").split('\n')
for repository in repositories:
    if repository == "":
        continue
    repoName = re.sub("\s+", ",", repository.strip()).split(",")[0]
    url = "localhost:9200/_cat/snapshots/" + repoName + "?pretty"
    print("running URL: " + url)

    indices = execute_bash(['curl', '-s', '-X', 'GET', url]).decode("utf-8").split('\n')
    for index in indices:
        if index == "":
            continue
        print("index: " + index)
