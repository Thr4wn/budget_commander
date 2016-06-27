here=`dirname $0`
importers_folder=importers
importers=$here/$importers_folder

#vagrant up

for i in `ls $importers`; do
    $importers/$i/import.sh
done

