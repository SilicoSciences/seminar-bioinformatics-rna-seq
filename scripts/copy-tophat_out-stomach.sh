#!/bin/bash
set -e

desc="Copy tophat_out (stomach)"

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {369,379,467,485}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"

scp -r "alex@silico-sciences.com:/home/bi/2014fagerberg-small/ERR315${i}/tophat_out-small/" "ERR315${i}/"
done


