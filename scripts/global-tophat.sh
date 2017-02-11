#!/bin/bash

gtf=/var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf
transciptIndex=/var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/transciptome_index/genes

function f_tophat {
echo "tophat"
tophat -p$processes -G $gtf --transcriptome-index $transciptIndex -o "ERR315${i}/$tophatOut" $bowtie2Index "ERR315${i}/ERR315${i}$fastqPostfix1" "ERR315${i}/ERR315${i}$fastqPostfix2"
exitCode=$?
echo "tophat exit code $exitCode"
return $exitCode
}

function f_doIt {
if [ -f "ERR315${i}/$tophatOut/align_summary.txt" ] && ([ -f "ERR315${i}/$tophatOut/accepted_hits.bam" ] || [ -f "ERR315${i}/$cuffquantOut/abundances.cxb" ])
    then
    echo "Files exist, skipping Tophat, counting reads"
    if ! [ -f "ERR315${i}/$tophatOut/accepted_hits_sorted.bam" ]
        then
        echo "samtools sort accepted"
        samtools sort "ERR315${i}/$tophatOut/accepted_hits.bam" "ERR315${i}/$tophatOut/accepted_hits_sorted" -@4 -m10G
    fi
    if ! [ -f "ERR315${i}/$tophatOut/unmapped_sorted.bam" ] && [ -f "ERR315${i}/$tophatOut/unmapped.bam" ]
        then
        echo "samtools sort unmapped"
        samtools sort "ERR315${i}/$tophatOut/unmapped.bam" "ERR315${i}/$tophatOut/unmapped_sorted" -@4 -m10G
    fi
    echo "samtools view"
    mapped=$(samtools view -F 0x40 "ERR315${i}/$tophatOut/accepted_hits_sorted.bam" | cut -f1 | sort | uniq | wc -l)
    if [ -f "ERR315${i}/$tophatOut/unmapped_sorted.bam" ]
        then
        unmapped=$(samtools view -F 0x40 "ERR315${i}/$tophatOut/unmapped_sorted.bam" | cut -f1 | sort | uniq | wc -l)
    fi
    echo "Total reads: $((mapped + unmapped))"
else
f_tophat
fi
}

function f_cleanup {
while [ "$1" != "" ]; do
  f_cleanup2 "$1" && shift;
done;
}

function f_delete {
while [ "$1" != "" ]; do
  f_delete2 "$1" && shift;
done;
}

function f_cleanup2 {
echo "dollarOne: ${1}"
for f in ${1}/$tophatOut/accepted_hits.bam
do
echo "f: ${f}"
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Cleaning $1/$tophatOut/"
echo "-------------------------------------------"
if [[ -f $f ]]; then
echo "hieroglyph: ${f%/*}"
rm -rf "${f%/*}"/tmp
rm -rf "${f%/*}"/logs
rm -f "${f%/*}"/*_sorted.bam
rm -f "${f%/*}"/*.bai
fi
done
}

function f_delete2 {
echo "dollarOne: ${1}"
for f in ${1}/$tophatOut/accepted_hits.bam
do
echo "f: ${f}"
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Deleting $1/$tophatOut/"
echo "-------------------------------------------"
rm -rf "${f%/*}"
done
for f in ${1}/$cuffquantOut/abundances.cxb
do
echo "f: ${f}"
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Deleting $1/$cuffquantOut/"
echo "-------------------------------------------"
rm -rf "${f%/*}"
done
}
