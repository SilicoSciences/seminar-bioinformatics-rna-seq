#!/bin/bash
set -e

source global-tophat.sh

desc="Cleanup Tophat lung large"

tophatOut=tophat_out

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {424,353,487,444}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"
f_cleanup "ERR315${i}"
done
echo "All done!"
