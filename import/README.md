Importing Data
==============

`./import.sh` will

 * start vagrant machine for importers to use.
 * run all importers (importers/*/import.sh)

Subfolders
----------

`importers/*/import.sh` should ultimately add data to activity table with
'stage' set to 'importing'.

Usually, this is done via the following steps:

1. Download csv (selenium)
2. Convert (ruby)
3. Load (psql)

