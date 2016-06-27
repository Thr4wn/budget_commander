
here=`dirname $0`
ppfm_root=$here/../..

$here/download.sh

stop_day=`psql -U sbird -d ppfm -c 'select max(day) from activity'  | awk NR==3`
echo pnc preimport.sh: stop_day = $stop_day
$here/convert.rb $stop_day

#$here/load.sh

