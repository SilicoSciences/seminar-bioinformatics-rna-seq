#!/bin/bash

function f_wget {
echo "wget"
wget -qcP "ERR315${i}" "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR315/ERR315${i}/ERR315${i}_1.fastq.gz" "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR315/ERR315${i}/ERR315${i}_2.fastq.gz"
echo "wget exit code $?"
echo "MD5 sums"
md5sum "ERR315${i}"/*.fastq.gz
}

function f_doIt {
## Do it
f_wget
## if [[ $? -ne 0 ]] ; then
## echo "fail with exit code $?"	## do not fail for now, just check nohup out
## exit 1
## fi
}
