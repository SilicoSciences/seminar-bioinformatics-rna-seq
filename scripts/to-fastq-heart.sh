#!/bin/bash
set -e

desc="Convert back to fastq (heart)"

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {328,331,356,367}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"

bedtools bamtofastq -i "ERR315${i}/tophat_out/accepted_hits_chr22.bam" -fq "ERR315${i}/accepted_hits_chr22_1.fastq" -fq2 "ERR315${i}/accepted_hits_chr22_2.fastq" 2>/dev/null

done


