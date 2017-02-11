#!/bin/bash
set -e

source global-tophat.sh

desc="Map lung dataset large"

fastqPostfix1=_1.fastq.gz
fastqPostfix2=_2.fastq.gz
tophatOut=tophat_out
processes=7
bowtie2Index=/var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Sequence/Bowtie2Index/genome

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


