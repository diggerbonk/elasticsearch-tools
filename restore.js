var client = require('./connection.js');
var fs = require('fs');
var path = require('path');

async function createIndex(indexName, indexMappings)
{
  console.log(indexMappings);
  await client.indices.create({
    index: indexName,
    body: {
      mappings: indexMappings
    }
  });
}

async function addDocument(indexName, doc)
{
    console.log(JSON.stringify(doc, null, 2));
    await client.index({
	id: doc._id,
	index: indexName,
	body: doc._source,
	refresh: true
    });
}

function walkSync(dir, filelist = []) {

    const files = fs.readdirSync(dir);

    for (const file of files) {

        if (file === "size" || file === "mappings.json") continue;
        const filepath = path.join(dir, file);
        const stat = fs.statSync(filepath);

        if (stat.isDirectory()) {
            walkSync(filepath, filelist);
        } 
        else if (stat.isFile()) {
            filelist.push(filepath);
        }
    }
    return filelist;
}

async function main(args) {

    let indexStr = args[2];
    let rootPath = args[3];

    let mappings = JSON.parse(fs.readFileSync(rootPath + "/mappings.json").toString());
 
    await createIndex(indexStr, mappings);

    fileList = walkSync(rootPath);

    for (i = 0; i < fileList.length; i++) {
        data = JSON.parse(fs.readFileSync(fileList[i]).toString());
        for (j = 0; j < data.length; j++) {
            await addDocument(indexStr, data[j]);
        }
    }
};

try {
    main(process.argv);
}
catch (e) {
    console.log("ERROR", e);
}
