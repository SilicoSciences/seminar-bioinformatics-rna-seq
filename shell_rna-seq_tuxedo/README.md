Title: The Cloud and the Shell - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: training at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg

# Applied Bioinformatics in the Cloud and in the Shell

## RNA-Seq Analysis Using Unix and Open Source Tools 

[TOC]

# Recap

### Nohup

`nohup`: run a command immune to hangups, with output to a non-tty

    $ nohup p1 &
    [1] 14958
    $ less nohup.out
    
### Remote Shell

#### Preparations

0. Get and save the key file

0. `cd` to the corresponding directory

0. 'Install' the ssh key

        $ ssh-add training@silico_rsa 
        Enter passphrase for training@silico_rsa: 
        Identity added: training@silico_rsa (training@silico_rsa)
        
0. In case of permissions error, fix permissions

        $ chmod 600 training@silico_rsa
        
0. In case of an ssh-agent error, fix as described [here](https://silico-sciences.com/2015/11/04/could-not-open-a-connection-to-your-authentication-agent/)
        
---

`ssh`: OpenSSH SSH client (remote login program)

    $ ssh silico-sciences.com
    
    $ ssh 176.28.21.178

    $ ssh [yourname]@silico-sciences.com
   
---
    
0. Login to the remote system using `[yourname]@silico-sciences.com`

0. Verify successful login:

    0. `whoami`
    
    0. `hostname`
    
    0. `ifconfig`
    
    0. Get some system infos:
    
            $ cat /etc/lsb-release
            DISTRIB_ID=Ubuntu
            DISTRIB_RELEASE=14.04
            DISTRIB_CODENAME=trusty
            DISTRIB_DESCRIPTION="Ubuntu 14.04.3 LTS"
            
    0. Type these commands on the remote system and on the local system.

# RNA-Seq using the Shell, IGV and the Tuxedo Suite

## Getting Data

Use `wget` to download data from [here](https://raw.githubusercontent.com/SilicoSciences/seminar-bioinformatics-rna-seq/master/galaxy_rna-seq_tuxedo/download-links-chr03.txt).

There are many ways to retrieve all files in that list, here are some hints:
    
+ Download this list as a file.
        
+ Use `sed` or `tr` to replace all new line characters (`\n`) with a space character (` `).

+ Pipe the resulting list to a file or directly to `wget`.
        
+ Take a look at `wget`s `-i` option.
    
+ Use `wget` with the `--no-directories`, the `--accept-regex` and the `--recursive` option.
    
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

        $ cuffquant [reference-annotation].gtf [tophat_out]/accepted_hits.bam
    
    Options (less speed, more accuracy):

    0. `-b/--frag-bias-correct`: use bias correction - reference fasta required

    0. `-u/--multi-read-correct`: use 'rescue method' for multi-reads
    
            $ cuffquant -b [reference-seq].fa -u [reference-annotation].gtf [tophat_out]/accepted_hits.bam
        

0. Use `Cuffdiff` to find significant changes in expression level.

        $ cuffdiff -o [some-out-dir] -L Lung,Stomach,Heart [reference-annotation].gtf [lung1-4-cuffquant_out]/abundances.cxb,[lung2-4-cuffquant_out]/abundances.cxb,[lung3-4-cuffquant_out]/abundances.cxb,[lung4-4-cuffquant_out]/abundances.cxb [stomach1-4-cuffquant_out]/abundances.cxb,[stomach2-4-cuffquant_out]/abundances.cxb,[stomach3-4-cuffquant_out]/abundances.cxb,[stomach4-4-cuffquant_out]/abundances.cxb [heart1-4-cuffquant_out]/abundances.cxb,[heart2-4-cuffquant_out]/abundances.cxb,[heart3-4-cuffquant_out]/abundances.cxb,[heart4-4-cuffquant_out]/abundances.cxb
        
    **Note:** Pay attention to correct usage of commas and spaces. Separate replicates with commas (*don't* use `,[whitespace]`) and conditions/ labels with space.
    
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

[Back to Index](../README.md)
    
## References

0. [SAM/BAM format](https://samtools.github.io/hts-specs/SAMv1.pdf)

0. [Differential gene and transcript expression analysis of RNA-seq experiments with TopHat and Cufflinks](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3334321)

0. [Analysis of the Human Tissue-specific Expression by Genome-wide Integration of Transcriptomics and Antibody-based Proteomics](http://www.mcponline.org/content/13/2/397)

0. [Cufflinks manual](http://cole-trapnell-lab.github.io/cufflinks/manual/)

