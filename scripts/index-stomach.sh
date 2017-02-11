#!/bin/bash
set -e

desc="index data (stomach)"

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {369,379,467,485}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"

echo "sort"
samtools sort "ERR315${i}/accepted_hits.bam" "ERR315${i}/accepted_hits_sorted"
echo "index"
samtools index "ERR315${i}/accepted_hits_sorted.bam"

done


