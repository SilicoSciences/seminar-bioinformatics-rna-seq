#!/bin/bash
set -e

desc="Copy tophat_out (lung)"

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {326,341,346,353}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"

scp -r "alex@silico-sciences.com:/home/bi/2014fagerberg-small/ERR315${i}/tophat_out-small/" "ERR315${i}/"
done


