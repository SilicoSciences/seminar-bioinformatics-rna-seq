#!/bin/bash
set -e

desc="Reduce bam to chr22 (heart)"

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {328,331,356,367}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"

echo "sort"
samtools sort "ERR315${i}/tophat_out/accepted_hits.bam" "ERR315${i}/tophat_out/accepted_hits_sorted" -@8 -m16G
echo "index"
samtools index "ERR315${i}/tophat_out/accepted_hits_sorted.bam"
echo "filter"
samtools view -b "ERR315${i}/tophat_out/accepted_hits_sorted.bam" 22 > "ERR315${i}/tophat_out/accepted_hits_chr22.bam"

done


