var client = require('./connection.js');
var fs = require('fs');

async function main(args) {


    let indexStr = args[2];
    let rootPath = args[3];

    let indexInfo = await client.indices.get({index: indexStr});

    console.log(indexInfo);
    fs.writeFileSync(rootPath + "/mappings.json", JSON.stringify(indexInfo.body[indexStr].mappings, null, 2));

    let searchParams = {
        index: args[2],
	body: {
	    query: {
		match_all: {}
	    }
	}
    };

    let counter = 101;
    let count = 0;
    let recordCount = 0;

    for await (const result of client.helpers.scrollSearch(searchParams)) {
 
        if (counter > 100) {
            currentRoot = (rootPath + "/" + count);
            fs.mkdirSync(currentRoot);
            count += 1;
            counter = 0;
        }
        else {
            counter += 1;
        }

        fs.writeFileSync(currentRoot + "/" + counter + ".json", JSON.stringify(result.body.hits.hits, null, 2));
        recordCount += result.body.hits.hits.length;
    }

    fs.writeFileSync(rootPath + "/size", recordCount.toString());
};

try {
    main(process.argv);
}
catch (e) {
    console.log("ERROR", e);
}
