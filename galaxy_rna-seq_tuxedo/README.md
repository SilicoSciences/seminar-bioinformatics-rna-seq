Title: The Cloud and the Shell - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: training at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg 2016-01-20 - 2016-01-22

# Applied Bioinformatics in the Cloud and in the Shell

## NGS Data Analysis Using Unix and Open Source Tools

[TOC]

# RNA-Seq using Galaxy, IGV and the Tuxedo Suite

For this tutorial we will work with the following dataset:

http://www.ebi.ac.uk/ena/data/view/ERP003613

NGS data processing is usually very time consuming, which is why some data has been already partically processed.

A subset of the original dataset (lung, stomach and heart) as well as some preprocessed data you can access here:

ftp://public:public@silico-sciences.com/2014fagerberg

Furthermore, this data has been reduced in size (chromosome 3 only) so processing will not take too long (usually a matter of hours or even days).

Find the small dataset here

ftp://public:public@silico-sciences.com/2014fagerberg-small

or in this GitHub repository

[2014fagerberg-small](../2014fagerberg-small)

## Import Data into Galady

![upload](../figs/galaxy_tools_upload.png)

Galaxy provides different possibilities to [import/ upload data](https://wiki.galaxyproject.org/Learn/ManagingDatasets).

Here, you can copy&paste the file URLs into the Galaxy upload wizard to transfer the data from server to server, without the need to download it to your local machine.

### Reference Sequence

Use the link below to get the reference sequence:

[3.fa.gz](../2014fagerberg-small/3.fa.gz?raw=true)
    
Reference sequences are stored in the [FASTA format](https://silico-sciences.com/2016/01/15/fasta-format/).
    
The file extension for FASTA files is `.fasta`, `.fa` or the according compressed version `fasta.gz` and `fa.gz`.

### Reference Annotation

Use the link below to get the reference annotation:

[genes_chr03.gtf.gz](../2014fagerberg-small/genes_chr03.gtf.gz?raw=true)

The file format should be [GTF](http://www.ensembl.org/info/website/upload/gff.html).

This file provides meta information on the (anonymous) reference sequence, such as exons, CDSs or start- and stop codons.

### Sequencing Reads

Use the links below to get the `fastq.gz` files:


0. Lung
    0. rep1
    [lung1-4_1](../2014fagerberg-small/lung/ERR315326/ERR315326_chr03_1.fastq.gz?raw=true)
    [lung1-4_2](../2014fagerberg-small/lung/ERR315326/ERR315326_chr03_2.fastq.gz?raw=true)
    
    0. rep2
    [lung2-4_1](../2014fagerberg-small/lung/ERR315341/ERR315341_chr03_1.fastq.gz?raw=true)
    [lung2-4_2](../2014fagerberg-small/lung/ERR315341/ERR315341_chr03_2.fastq.gz?raw=true)
    
    0. rep3
    [lung3-4_1](../2014fagerberg-small/lung/ERR315346/ERR315346_chr03_1.fastq.gz?raw=true)
    [lung3-4_2](../2014fagerberg-small/lung/ERR315346/ERR315346_chr03_2.fastq.gz?raw=true)
    
    0. rep4
    [lung4-4_1](../2014fagerberg-small/lung/ERR315353/ERR315353_chr03_1.fastq.gz?raw=true)
    [lung4-4_2](../2014fagerberg-small/lung/ERR315353/ERR315353_chr03_2.fastq.gz?raw=true)
    
0. Stomach

    0. rep1
    [stomach1-4_1](../2014fagerberg-small/stomach/ERR315369/ERR315369_chr03_1.fastq.gz)
    [stomach1-4_2](../2014fagerberg-small/stomach/ERR315369/ERR315369_chr03_2.fastq.gz)
    
    0. rep2
    [stomach2-4_1](../2014fagerberg-small/stomach/ERR315379/ERR315379_chr03_1.fastq.gz)
    [stomach2-4_2](../2014fagerberg-small/stomach/ERR315379/ERR315379_chr03_2.fastq.gz)
    
    0. rep3
    [stomach3-4_1](../2014fagerberg-small/stomach/ERR315467/ERR315467_chr03_1.fastq.gz)
    [stomach3-4_2](../2014fagerberg-small/stomach/ERR315467/ERR315467_chr03_2.fastq.gz)
    
    0. rep4
    [stomach4-4_1](../2014fagerberg-small/stomach/ERR315485/ERR315485_chr03_1.fastq.gz)
    [stomach4-4_2](../2014fagerberg-small/stomach/ERR315485/ERR315485_chr03_2.fastq.gz)
    
Alternatively find the download links [here](downlaod-links.txt).


NGS data is stored in the [FASTQ format](https://silico-sciences.com/2016/01/15/fastq-format/). These files are usually the starting point of the NGS data processing.
    
If the reads are [paired-end](http://seqanswers.com/forums/showthread.php?t=503), you are usually provided with two files per sample (`_1.fastq.gz` and `_2.fastq.gz`).
    

### Inspecting the Data and Quality Control

0. Take a look at the content of the uploaded files.

    ![view](../figs/galaxy_data_options_view.png)
        
0. Use [FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to take a look at the overall read quality and sample details. The quality scores in the FASTQ files can be in different [encodings](https://en.wikipedia.org/wiki/FASTQ_format#Encoding). FastQC can automatically detect the encoding and reports it in the "Base Statistics" sections:

    ![base-statistics](../figs/FastQC_baseStatistics.png)
    
    The tools we are using need to know about the quality encoding that is present in the FASTQ files to probably interpret the quality of the base calls. Our files are in "Sanger" format, so we need to edit the data attributes for the loaded `fastq.gz` files to "fastqsanger".

0. Use [Trim Galore!](http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/) to trimm the reads.
        
0. Compare read quality of trimmed vs. non-trimmed reads.

0. Answer the following questions for trimmed and non-trimmed data:

    0. Which quality encoding was used?
    
    0. What is the read length distribution?
    
    0. What is the quality score distribution?

### Mapping Reads to the Reference Sequence

0. Use [TopHat](https://ccb.jhu.edu/software/tophat/index.shtml) to map reads to reference from history (`3.fa.gz`). TopHat is a splice-aware aligner, so it can handle RNA-Seq data and is able to align reads across introns.

> Bowtie is not suitable for all sequence alignment tasks. It does not allow alignments between a read and the genome to contain large gaps; hence, it cannot align reads that span introns. TopHat was created to address this limitation. TopHat uses Bowtie as an alignment 'engine' and breaks up reads that Bowtie cannot align on its own into smaller pieces called segments. Often, these pieces, when processed independently, will align to the genome. When several of a read's segments align to the genome far apart (e.g., between 100 bp and several hundred kilobases) from one another, TopHat infers that the read spans a splice junction and estimates where that junction's splice sites are.
([Differential gene and transcript expression analysis of RNA-seq experiments with TopHat and Cufflinks](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3334321))
        
0. Choose `Paired-end (as individual datasets)`.
       
0. Select forward and reverse reads from each sample.

0. Choose `Use a genome from history`

0. Select `3.fa`
      
0. Take a look at the newly added files ([BAM](https://silico-sciences.com/2016/01/15/sam-bam-format/)).

0. Answer the following questions:

    0. How many reads could be sucesfully aligned?
    
    0. How many reads could be uniquely aligned?

## Use IGV to Visualize the Mapping

0. Download mappings `accepted_hits.bam` and its index file.
    
0. Load bam files into IGV.
    
    0. Navigate by typing gene names into the search box.
    
    0. Navigate by Drag&Drop.
    
    0. Zoom in and out using the "railroad track".
    
    0. Double click to get online info.
    
    0. Change display:
    
        0. Collapsed
        
        0. Expanded
        
        0. Squished
        
    0. Load additional data from server, e.g. dbSNP.
    
0. Use `Cuffquant` to precompute gene expression levels.

0. Use `Cuffnorm` to create normalized expression values.

0. Use `Cuffdiff` to find significant changes in expression level.

    0. Generate SQLite.
    0. Do *not* omit Tabular Datasets.
    
0. Use `cummeRbund` to visualize data.

## References

0. [Galaxy Wiki](https://github.com/nekrut/galaxy/wiki)

0. [Galaxy forum](https://biostar.usegalaxy.org/)

0. [FASTQ format#Quality](https://en.wikipedia.org/wiki/FASTQ_format#Quality)

0. [Differential gene and transcript expression analysis of RNA-seq experiments with TopHat and Cufflinks](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3334321)

0. [Analysis of the Human Tissue-specific Expression by Genome-wide Integration of Transcriptomics and Antibody-based Proteomics](http://www.mcponline.org/content/13/2/397)

0. [Cufflinks manual](http://cole-trapnell-lab.github.io/cufflinks/manual/)

0. [CummeRbund manual](http://compbio.mit.edu/cummeRbund/manual_2_0.html)
