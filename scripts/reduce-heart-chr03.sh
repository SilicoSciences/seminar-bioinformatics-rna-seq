#!/bin/bash
set -e

source global-reduce.sh

desc="Reduce bam to chr03 (heart)"

processes=8

mem=16G

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {384,413,331,367}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"
f_doIt
done
echo "All done!"
