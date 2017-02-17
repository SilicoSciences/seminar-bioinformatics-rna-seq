#!/bin/bash
set -e

source global-cuffquant.sh

desc="Cuffquant lung large"
cuffquantOut=cuffquant_out
processes=7
tophatOut=tophat_out
bowtie2Index=/var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Sequence/Bowtie2Index/genome.fa
annotations=/var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf

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
