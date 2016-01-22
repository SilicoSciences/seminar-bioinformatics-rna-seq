Title: The Cloud and the Shell - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: training at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg 2016-01-20 - 2016-01-22

# Applied Bioinformatics in the Cloud and in the Shell

## NGS Data Analysis Using Unix and Open Source Tools 

[TOC]

# RNA-Seq using the Shell, IGV and the Tuxedo Suite

## Getting Data

Use `wget` to download the following files:

    ftp://public:public@silico-sciences.com/2014fagerberg-small/3.fa.gz
    ftp://public:public@silico-sciences.com/2014fagerberg-small/genes_chr03.gtf.gz
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315326/ERR315326_chr03_1.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315326/ERR315326_chr03_2.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315341/ERR315341_chr03_1.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315341/ERR315341_chr03_2.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315346/ERR315346_chr03_1.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315346/ERR315346_chr03_2.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315353/ERR315353_chr03_1.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315353/ERR315353_chr03_2.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315369/ERR315369_chr03_1.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315369/ERR315369_chr03_2.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315379/ERR315379_chr03_1.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315379/ERR315379_chr03_2.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315467/ERR315467_chr03_1.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315467/ERR315467_chr03_2.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315485/ERR315485_chr03_1.fastq
    ftp://public:public@silico-sciences.com/2014fagerberg-small/ERR315485/ERR315485_chr03_2.fastq
    
## Creating a Bowtie2 index

`TopHat` uses `Bowtie2` as a 'mapping engine'. `Bowtie2` requires the reference genome to be indexed.

Create this index file as described [here](https://silico-sciences.com/2015/11/11/create-bowtie2-index-for-reference-genome/).

## Mapping Reads to the Reference Sequence

Use `Tophat` to map the reads to the reference genome:

    $ tophat -G genes_chr03.gtf 3 input_1_fastq input_2_fastq