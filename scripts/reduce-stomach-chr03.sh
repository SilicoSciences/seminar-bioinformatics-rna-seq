#!/bin/bash
set -e

source global-reduce.sh

desc="Reduce stomach to chr03"
processes=8
mem=16G
tophatOut=tophat_out
skipFilter=false

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {369,485,467,379}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"
f_doIt
done
echo "All done!"
