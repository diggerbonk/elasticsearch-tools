var client = require('./connection.js');
var fs = require('fs');
var path = require('path');

function walkSync(dir, filelist = []) {

    const files = fs.readdirSync(dir);

    for (const file of files) {

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

    let rootPath = args[3];

    fileList = walkSync(rootPath);

    for (i = 0; i < fileList.length; i++) {
        data = JSON.parse(fs.readFileSync(fileList[i]).toString());
        str = JSON.stringify(data, null, 2);
        console.log(str);
    }
};

try {
    main(process.argv);
}
catch (e) {
    console.log("ERROR", e);
}
