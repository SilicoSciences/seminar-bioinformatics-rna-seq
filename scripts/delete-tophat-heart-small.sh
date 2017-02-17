#!/bin/bash
set -e

source global-tophat.sh

desc="Delete Tophat heart small"

tophatOut=tophat_out_small
cuffquantOut=cuffquant_out

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {384,413,356,430}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"
f_delete "ERR315${i}"
done
echo "All done!"
