var client = require('./connection.js');

async function main(args) {
    let indexStr = args[2];
    let indexInfo = await client.indices.get({index: indexStr});
    console.log(JSON.stringify(indexInfo.body, null, 2));
};

try {
    main(process.argv);
}
catch (e) {
    console.log("ERROR", e);
}
