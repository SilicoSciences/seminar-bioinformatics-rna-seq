#!/bin/bash
#set -e

function f_wget {
if [ -f "ERR315${i}/tophat_out/accepted_hits.bam" ] || [ -f "ERR315${i}/cuffquant_out/abundances.cxb" ]
then
echo "Files exist, scipping wget"
else
echo "wget"
wget -cqP "ERR315${i}" "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR315/ERR315${i}/ERR315${i}_1.fastq.gz" "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR315/ERR315${i}/ERR315${i}_2.fastq.gz"
fi
}


function f_trim {
echo "sickle"
if [ -f "ERR315${i}/tophat_out/accepted_hits.bam" ] || [ -f "ERR315${i}/cuffquant_out/abundances.cxb" ] || ([ -f "ERR315${i}/ERR315${i}_1_trimmed.fastq.gz" ] && [ -f "ERR315${i}/ERR315${i}_2_trimmed.fastq.gz" ])
then
echo "Files exist, scipping trim"
else
sickle pe -f "ERR315${i}/ERR315${i}_1.fastq.gz" -r "ERR315${i}/ERR315${i}_2.fastq.gz" -o "ERR315${i}/ERR315${i}_1_trimmed.fastq.gz" -p "ERR315${i}/ERR315${i}_2_trimmed.fastq.gz" -t sanger -q 20 -l 54 -g -s "ERR315${i}/ERR315${i}_trimmed_singles.fastq.gz"
fi

}


function f_tophat {
echo "Tophat"
if [ -f "ERR315${i}/tophat_out/accepted_hits.bam" ] || [ -f "ERR315${i}/cuffquant_out/abundances.cxb" ]
then
echo "Files exist, scipping Tophat"
else
tophat -p8 -G /var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf -o "ERR315${i}/tophat_out" /var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Sequence/Bowtie2Index/genome "ERR315${i}/ERR315${i}_1_trimmed.fastq.gz" "ERR315${i}/ERR315${i}_2_trimmed.fastq.gz"
fi

}


function f_cuffquant {
echo "Cuffquant"
if [ -f "ERR315${i}/cuffquant_out/abundances.cxb" ]
then
echo "Files exist, scipping Cuffquant"
else
cuffquant -o "ERR315${i}/cuffquant_out" -q -p8 -b /var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Sequence/WholeGenomeFasta/genome.fa -u /var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf "ERR315${i}/tophat_out/accepted_hits.bam"
fi
}


function clear_wget {
echo "Clearing wget"
rm "ERR315${i}/ERR315${i}_1.fastq.gz" "ERR315${i}/ERR315${i}_2.fastq.gz" 2>/dev/null || true
}


function clear_sickle {
echo "Clearing sickle"
rm "ERR315${i}/ERR315${i}_1_trimmed.fastq.gz" "ERR315${i}/ERR315${i}_2_trimmed.fastq.gz" "ERR315${i}/ERR315${i}_trimmed_singles.fastq.gz" 2>/dev/null || true
}


function clear_tophat {
echo "Clearing Tophat"
rm -r "ERR315${i}/tophat_out" 2>/dev/null || true

}



for i in {325..500}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"

## Get Data
f_wget
status=$?
if [ $status -ne 0 ]; then
	echo "error downloading $i, exit code $status"
fi

## Trimm Data
f_trim
status=$?
if [ $status -ne 0 ]; then
	echo "error trimming $i, exit code $status"
fi

status=$?

## Tophat
f_tophat
status=$?
if [ $status -ne 0 ]; then
	echo "error Tophat $i, exit code $status"
else
clear_wget
clear_sickle
fi

status=$?

## Cuffquant
f_cuffquant
status=$?
if [ $status -ne 0 ]; then
	echo "error Cuffquant $i, exit code $status"
else
clear_tophat
fi
status=$?
done


