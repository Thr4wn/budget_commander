
file=`pwd`/$1
psql -U sbird -d ppfm -c "COPY activity FROM '$file' DELIMITER ',' CSV;"

