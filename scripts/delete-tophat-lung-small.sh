#!/bin/bash
set -e

source global-tophat.sh

desc="Delete Tophat lung small"

tophatOut=tophat_out_small
cuffquantOut=cuffquant_out

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {424,353,487,444}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"
f_delete "ERR315${i}"
done
echo "All done!"
