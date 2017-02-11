#!/bin/bash
set -e

desc="index data (lung)"

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {326,341,346,353}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"

echo "sort"
samtools sort "ERR315${i}/accepted_hits.bam" "ERR315${i}/accepted_hits_sorted"
echo "index"
samtools index "ERR315${i}/accepted_hits_sorted.bam"

done


