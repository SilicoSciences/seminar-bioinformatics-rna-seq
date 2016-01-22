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
    
0. First possibility:

    0. Download this list as a file:
    `https://raw.githubusercontent.com/SilicoSciences/seminar-bioinformatics/master/galaxy_rna-seq_tuxedo/download-links.txt`

    0. Use `sed` or `tr` to replace all new line characters (`\n`) with a space character (` `).

    0. Pipe the resulting list to a file or directly to `wget`.
    
0. Second possibility:

    0. Use `wget` with the `--no-directories`, the `--accept-regex` and the `--recursive` option.
    
## Creating a Bowtie2 index

`TopHat` uses `Bowtie2` as a 'mapping engine'. `Bowtie2` requires the reference genome to be indexed.

Create this index file as described [here](https://silico-sciences.com/2015/11/11/create-bowtie2-index-for-reference-genome/).

## Mapping Reads to the Reference Sequence

0. Use `Tophat` to map the reads to the reference genome:

        $ tophat -o [some-out-dir] -G [reference-annotation].gtf [reference-bowtie2-index-file] [reads]_1_fastq [reads]_2_fastq
    
       `Tophat` produces several output files: 

       0. `accepted_hits.bam`
  
    **Note:** See [here](https://silico-sciences.com/2016/01/03/tophat-transcriptome-index/) howto avoid repetitive index building. Find a pre-build transcriptome index for chromosome three here `/var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/transciptome_index/genes_chr03`.

0. Use `samtools idxstats` to see the number of mapped/ unmapped reads in the created `accepted_hits.bam` file (see [here](https://silico-sciences.com/2015/11/20/get-number-of-mapped-unmapped-reads-per-chromosome/)).

        $ samtools idxstats accepted_hits_sorted.bam | column -t
        3  198022430  14926  0
        *  0          0      0

        $ samtools idxstats unmapped_sorted.bam | column -t
        3  198022430  0  0
        *  0          0  2
        
0. Take a look at the `bam` files:

    0. `less accepted_hits.bam`
    
    0. `zless accepted_hits.bam`
    
    0. `samtools view accepted_hits.bam`

 
## Calculate Gene Expressions

0. Use `Cuffquant` to precompute gene expression levels.

        $ cuffquant -b [reference-seq].fa -u [reference-annotation].gtf [tophat_out]/accepted_hits.bam
    
    Options:

    0. `-b/--frag-bias-correct`: use bias correction - reference fasta required

    0. `-u/--multi-read-correct`: use 'rescue method' for multi-reads

0. Use `Cuffdiff` to find significant changes in expression level.

        $ cuffdiff -o [some-out-dir] -L Lung,Stomach [reference-annotation].gtf [lung1-4-cuffquant_out]/abundances.cxb,[lung2-4-cuffquant_out]/abundances.cxb,[lung3-4-cuffquant_out]/abundances.cxb,[lung4-4-cuffquant_out]/abundances.cxb [stomach1-4-cuffquant_out]/abundances.cxb,[stomach2-4-cuffquant_out]/abundances.cxb,[stomach3-4-cuffquant_out]/abundances.cxb,[stomach4-4-cuffquant_out]/abundances.cxb
        
    **Note:** Pay attention to correct usage of commas and spaces. Separate replicates with commas (*don't* use `, `) and conditions/labels with space.
    
## Data Analysis

Cuffdiff writes fold changes to the table `[cuffdiff_out]/genes_exp.diff`.

0. Use `cut` to cut away columns that we are not interested in.

0. Use `sort` to sort the table by

    0. significance and
    
    0. absolute log2 fold change (descending).
    
0. use `grep` and `|` to extract lines with a significant regulation into a new file.

**Do not** override `[cuffdiff_out]/genes_exp.diff`. Use pipes instead!

---

If you ask yourself if it is worth to write a script or not, take a look at this matrix:

![matrix](https://imgs.xkcd.com/comics/is_it_worth_the_time.png)

---

[Back to Index](../seminar-bioinformatics)
    
## References

0. [SAM/BAM format](https://samtools.github.io/hts-specs/SAMv1.pdf)

0. [Differential gene and transcript expression analysis of RNA-seq experiments with TopHat and Cufflinks](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3334321)

0. [Analysis of the Human Tissue-specific Expression by Genome-wide Integration of Transcriptomics and Antibody-based Proteomics](http://www.mcponline.org/content/13/2/397)

0. [Cufflinks manual](http://cole-trapnell-lab.github.io/cufflinks/manual/)

