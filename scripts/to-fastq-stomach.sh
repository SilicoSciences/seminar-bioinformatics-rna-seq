#!/bin/bash
set -e

desc="Convert back to fastq (stomach)"

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
for i in {369,379,467,485}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"

bedtools bamtofastq -i "ERR315${i}/tophat_out/accepted_hits_chr03.bam" -fq "ERR315${i}/ERR315${i}_chr03_1.fastq" -fq2 "ERR315${i}/ERR315${i}_chr03_2.fastq" 2>/dev/null

done


