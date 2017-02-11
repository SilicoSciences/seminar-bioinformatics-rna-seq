#!/bin/bash
set -e

source global-reduce.sh

desc="Reduce bam to chr03 (lung)"
processes=8
mem=16G
tophatOut=tophat_out
skipFilter=false

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {424,353,487,444}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"
f_doIt
done
echo "All done!"
