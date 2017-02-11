#!/bin/bash
set -e

source global-tophat.sh

desc="Map stomach small"

fastqPostfix1=_chr03_1.fastq.gz
fastqPostfix2=_chr03_2.fastq.gz
tophatOut=tophat_out_small
processes=7
bowtie2Index=/var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Sequence/Bowtie2Index/genome

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


