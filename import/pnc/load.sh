here=`dirname $0`
converted_dir=$here/../private/converted

cd converted_dir
for i in `ls`; do
    psql -d ppfm -U sbird -f "$here/import.sql" -v converted_csv_file=$i
done

