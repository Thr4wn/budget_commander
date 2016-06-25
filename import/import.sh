here=`dirname $0`
psql -d ppfm -U sbird -f "$here/import.sql"
