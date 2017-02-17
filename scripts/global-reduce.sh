#!/bin/bash

function f_reduce {
echo "reduce"

if ! [ -f "ERR315${i}/$tophatOut/accepted_hits_sorted.bam" ]
    then
    echo "samtools sort accepted"
    samtools sort "ERR315${i}/$tophatOut/accepted_hits.bam" "ERR315${i}/$tophatOut/accepted_hits_sorted" -@$processes -m$mem
    echo "samtools sort exit code $?"
fi

if ! [ -f "ERR315${i}/$tophatOut/accepted_hits_sorted.bam.bai" ]
    then
    echo "samtools index accepted"
    samtools index "ERR315${i}/$tophatOut/accepted_hits_sorted.bam"
    echo "samtools index exit code $?"
fi

if $skipFilter
    then 
    echo "skipping filter"
    cp "ERR315${i}/$tophatOut/accepted_hits_sorted.bam" "ERR315${i}/$tophatOut/accepted_hits_chr03.bam"
    else
    echo "reduce filter"
    samtools view -b "ERR315${i}/$tophatOut/accepted_hits_sorted.bam" 3 > "ERR315${i}/$tophatOut/accepted_hits_chr03.bam"
    echo "samtools view exit code $?"
fi
echo "back 2 fastq"
bedtools bamtofastq -i "ERR315${i}/$tophatOut/accepted_hits_chr03.bam" -fq "ERR315${i}/ERR315${i}_chr03_1.fastq" -fq2 "ERR315${i}/ERR315${i}_chr03_2.fastq" 2>/dev/null
echo "bamtofastq exit code $?"
echo "gzip"
gzip -f "ERR315${i}/ERR315${i}_chr03_1.fastq" "ERR315${i}/ERR315${i}_chr03_2.fastq"
echo "gzip exit code $?"
}

function f_doIt {
f_reduce
}
