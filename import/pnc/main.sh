#TODO: execute selenium via vagrant
here=`dirname $0`
echo $here
ppfm_root=$here/../..
stop_day=`psql -U sbird -d ppfm -c 'select max(day) from activity'  | awk NR==3`
$here/convert.rb $stop_day
$ppfm_root/db/import.sh

