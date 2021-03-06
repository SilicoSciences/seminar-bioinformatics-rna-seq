#!/bin/bash
set -e

source global-reduce.sh

desc="Reduce heart to chr03"
processes=8
mem=16G
tophatOut=tophat_out
skipFilter=false

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {384,413,356,430}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"
f_doIt
done
echo "All done!"
