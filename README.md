# elasticsearch-tools

## get-all.js

$ node get-all.js <index> <backupDirectory>

Retrieves all documents from an index and makes a local backup. Results are broken into subdirectories of 100 files each. Each file contains a paged result set.
