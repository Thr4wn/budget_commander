here=`dirname $0`
ppfm_root=$here/../../..
private_dir=$ppfm_root/private
import_dir=$private_dir/import
downloaded_file=$import_dir/pnc-c-activity.csv
converted_file=$import_dir/pnc-c-converted.csv

$here/download.sh

stop_day=`psql -U sbird -d ppfm -c 'select max(day) from activity'  | awk NR==3`
echo pnc preimport.sh: stop_day = $stop_day
$here/convert.rb "$downloaded_file" "$converted_file" $stop_day

$here/load.sh "$converted_file"

