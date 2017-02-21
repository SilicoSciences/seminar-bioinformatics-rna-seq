Title: The Cloud and the Shell - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: training at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg

# Applied Bioinformatics in the Cloud and in the Shell

## RNA-Seq Analysis Using Unix and Open Source Tools 

[TOC]

# RNA-Seq using Galaxy, IGV and the Tuxedo Suite

## Getting the Data

For this tutorial we will work with the following dataset:

http://www.ebi.ac.uk/ena/data/view/ERP003613

http://www.ebi.ac.uk/ena/data/view/ERS326931-ERS327025

NGS data processing is usually very time consuming, which is why some data has been already partically processed.

Furthermore, the data has been reduced in size (chromosome 3 only) so processing will not take too long (usually a matter of hours or even days).

Below you find links to a subset of the original data, the preprocessed data as well as the chromosome 3 only datasets.

### Lung Original

ID | URL | md5 | Read Count
---|---|---|---
ERR315424 | http://www.ebi.ac.uk/ena/data/view/ERS326948 | `74368f3aaf69fa32a73c43e6cf7c32ee` `083f9c11f8c65a40bff289943d49524f` | 8,761,137
ERR315353 | http://www.ebi.ac.uk/ena/data/view/ERS326952 | `e07815132f75ad4acd626ba017b0f1b3` `ad9a286773704d120b84558253f915b1` | 13,576,003
ERR315487 | http://www.ebi.ac.uk/ena/data/view/ERS326952 | `64f66f5dfe6a15b72d060fe30900f899` `c07809ef2d7e905dddf718d6df17ebea` | 13,669,047
ERR315444 | http://www.ebi.ac.uk/ena/data/view/ERS327010 | `a47bb31a6beb7a59a9085313c824627e` `c704f62abbb76c7bb1408892f7f6716a` | 6,387,998

### Lung Reduced

ID | URL | md5 | Read Count
---|---|---|---
ERR315424 | ftp://public@silico-sciences.com/new/ERR315424/ERR315424_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315424/ERR315424_chr03_2.fastq.gz | `2d8e2cfce8449851eb4a9c0a39c417cc` `3348c4295275b31136e800bdefe8ebee` | 3873
ERR315353 | ftp://public@silico-sciences.com/new/ERR315353/ERR315353_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315353/ERR315353_chr03_2.fastq.gz | `32d6680538b3f7adf76e33810cef3864` `1b5c65d9b826a24b328f1fcb4551edb1` | 3200
ERR315487 | ftp://public@silico-sciences.com/new/ERR315487/ERR315487_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315487/ERR315487_chr03_2.fastq.gz | `2395a015534e03cd1e842275804e26f8` `a67e50045f35d013f75223449978fdfe` | 4875
ERR315444 | ftp://public@silico-sciences.com/new/ERR315444/ERR315444_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315444/ERR315444_chr03_2.fastq.gz | `c75154f04224905db8716641127b3363` `bb731b43a4c922dd3b92bd711a35064d` | 3276

### Stomach Original

ID | URL | md5 | Read Count
---|---|---|---
ERR315369 | http://www.ebi.ac.uk/ena/data/view/ERS326950 | `60b67df94f041c510977575525463a9d` `fe6230895aa051839e5ada69a8a0e5c9` | 16,004,990
ERR315485 | http://www.ebi.ac.uk/ena/data/view/ERS326950 | `6d8f45845c9dbb61e8d7a40db99e2c9b` `f1117143c7b450c576ade3dd32ba6df0` | 15,684,423
ERR315467 | http://www.ebi.ac.uk/ena/data/view/ERS327000 | `ac54c6fef08daf49b1c339f88231494c` `233f5b072fc327ff1caa97045feddc50` | 20,097,530
ERR315379 | http://www.ebi.ac.uk/ena/data/view/ERS327014 | `083bc3884d96c57cab5d2561a37e6304` `c97fbd4b8459382ae35cea6b86ffbe03` | 22,610,772

### Stomach Reduced

ID | URL | md5 | Read Count
---|---|---|---
ERR315369 | ftp://public@silico-sciences.com/new/ERR315369/ERR315369_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315369/ERR315369_chr03_2.fastq.gz | `f4c800960c694f32605ba2a2b64a0a35` `19d06f57d1577be2900cf54af1e95b88` | 15182
ERR315485 | ftp://public@silico-sciences.com/new/ERR315485/ERR315485_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315485/ERR315485_chr03_2.fastq.gz | `2abf1404b10fd5cbd942212ef7daa2a7` `43b4693d8934d587c345d48d38f7eee0` | 14775
ERR315467 | ftp://public@silico-sciences.com/new/ERR315467/ERR315467_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315467/ERR315467_chr03_2.fastq.gz | `6674b87cc3397d4e02dfe4a5423c6cff` `0c16723ca8afc2b43d59ea6d2e239216` | 14893
ERR315379 | ftp://public@silico-sciences.com/new/ERR315379/ERR315379_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315379/ERR315379_chr03_2.fastq.gz | `553d656b886e51d0aeda26d82378fd5c` `d5797e2e2f9673cb5c8af6dadd7aa93f` | 14812

### Heart Original

ID | URL | md5 | Read Count
---|---|---|---
ERR315384 | http://www.ebi.ac.uk/ena/data/view/ERS326973 | `0c13852e9bbddc1c2b056745ee6ffe6c` `0dcdbe173ed117fff7995ffaa0b4f1b6` | 16,695,109
ERR315413 | http://www.ebi.ac.uk/ena/data/view/ERS326973 | `f8473591adbcb929ad729d1427b97d52` `373d9a72ba830a96504c62a1486d55c1` | 16,596,950
ERR315356 | http://www.ebi.ac.uk/ena/data/view/ERS327004 | `db1a5470bd92049dfc7af541e17ad0ad` `090b337910da0209f819650e7565da02` | 17,732,535
ERR315430 | http://www.ebi.ac.uk/ena/data/view/ERS327004 | `05e09085cc4e09b3626e35c68e8284fe` `8b80a1c1ec49e42b08d0dad195dd9113` | 17,381,370

### Heart Reduced

ID | URL | md5 | Read Count
---|---|---|---
ERR315384 | ftp://public@silico-sciences.com/new/ERR315384/ERR315384_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315384/ERR315384_chr03_2.fastq.gz | `3ddef3455381ecd4099493055253c455` `5bfe358c01bdfe43ec8025e60e85fd53` | 6683
ERR315413 | ftp://public@silico-sciences.com/new/ERR315413/ERR315413_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315413/ERR315413_chr03_2.fastq.gz | `5a11a2924f7d452722756f4e42ddc9ef` `298941f7572f423302d5ae13bf7cd0eb` | 6766
ERR315356 | ftp://public@silico-sciences.com/new/ERR315356/ERR315356_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315356/ERR315356_chr03_2.fastq.gz | `8a8dffabeca2836ace01f0a4e8de9434` `598a7f2ead01aa65a2a4372837cd9d2f` | 8732
ERR315430 | ftp://public@silico-sciences.com/new/ERR315430/ERR315430_chr03_1.fastq.gz ftp://public@silico-sciences.com/new/ERR315430/ERR315430_chr03_2.fastq.gz | `2c6e035f6c1b7028e5b1a5eeba1571b2` `47194c4f4a349e9f5f65b6734000d818` | 8496

Find the main galaxy server here

https://usegalaxy.org/.

If you experience any problems you can try as well another server, as there are many [available](https://wiki.galaxyproject.org/PublicGalaxyServers).

## Import Data into Galady

![upload](../figs/galaxy_tools_upload.png)

Galaxy provides different possibilities to [import/ upload data](https://wiki.galaxyproject.org/Learn/ManagingDatasets).

Here, you can copy&paste the file URLs into the Galaxy upload wizard to transfer the data from server to server, without the need to download it to your local machine.

### Reference Sequence

Use the link below to get the reference sequence:

`ftp://public:public@silico-sciences.com/new/3.fa.gz`
    
Reference sequences are stored in the [FASTA format](https://silico-sciences.com/2016/01/15/fasta-format/).
    
The file extension for FASTA files is `.fasta`, `.fa` or the according compressed version `fasta.gz` and `fa.gz`.

### Reference Annotation

Use the link below to get the reference annotation:

`ftp://public:public@silico-sciences.com/new/genes_chr03.gtf.gz`

The file format should be [GTF](http://www.ensembl.org/info/website/upload/gff.html).

This file provides meta information on the (anonymous) reference sequence, such as exons, CDSs or start- and stop codons.

### Sequencing Reads

Get the "chr03-only" `fastq.gz` files.

NGS data is stored in the [FASTQ format](https://silico-sciences.com/2016/01/15/fastq-format/). These files are usually the starting point of the NGS data processing.
    
If the reads are [paired-end](http://www.yourgenome.org/facts/how-do-you-put-a-genome-back-together-after-sequencing), you are usually provided with two files per sample (`_1.fastq.gz` and `_2.fastq.gz`).
    

### Inspecting the Data and do Some Quality Control

0. Take a look at the content of the uploaded files.

    ![view](../figs/galaxy_data_options_view.png)
        
0. Use [FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to take a look at the overall read quality and sample details. The quality scores in the FASTQ files can be in different [encodings](https://en.wikipedia.org/wiki/FASTQ_format#Encoding). FastQC can automatically detect the encoding and reports it in the "Base Statistics" sections:

    ![base-statistics](../figs/FastQC_baseStatistics.png)
    
    The tools we are using need to know about the quality encoding that is present in the FASTQ files to probably interpret the quality of the base calls. Our files are in "Sanger" format, so we need to edit the data attributes for the loaded `fastq.gz` files to "fastqsanger".

    Find out more on handling FastQ quality scores in Galaxy [here](https://wiki.galaxyproject.org/Support#Troubleshooting_tool_errors).
    
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

0. Choose `Use a genome from history`.

0. Select `3.fa`.
      
0. Take a look at the newly added files ([BAM](https://silico-sciences.com/2016/01/15/sam-bam-format/)).

0. Answer the following questions:

    0. How many reads could be sucesfully aligned?
    
    0. How many reads could be uniquely aligned?
    
Other read mapper:

0. [HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml)
0. [STAR](https://github.com/alexdobin/STAR)
0. [GSNAP](http://research-pub.gene.com/gmap/)
0. [MapSplice](http://www.netlab.uky.edu/p/bioinfo/MapSplice)

## Use IGV to Visualize the Mapping

0. Download or web-start [IGV](https://www.broadinstitute.org/igv/startingIGV).

    Ubuntuusers: you can find IGV in the repositories. To install, type `sudo apt-get install igv`.

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
    
    0. Find out what else you can do!
    
Other Genome Browsers:

0. [UCSC](https://genome-euro.ucsc.edu/cgi-bin/hgTracks)
0. [Ensembl](http://www.ensembl.org/Homo_sapiens/Location/View?r=17:63973115-64437414)
    
## Calculate Gene Expressions

Use the reduced datasets to get an idea of the workflow and the input and output files.

Use the original dataset to perform a real gene expression comparison between lung, stomach and heart.
    
0. Use `Cuffquant` to precompute gene expression levels.

    From the Cufflinks [manual](http://cole-trapnell-lab.github.io/cufflinks/manual/):
    
    > Quantifying gene and transcript expression in RNA-Seq samples can be computationally expensive. Cuffquant allows you to compute the gene and transcript expression profiles and save these profiles to files that you can analyze later with Cuffdiff or Cuffnorm. This can help you distribute your computational load over a cluster and is recommended for analyses involving more than a handful of libraries.

0. Use `Cuffnorm` to create normalized expression values.

      From the Cufflinks [manual](http://cole-trapnell-lab.github.io/cufflinks/manual/):

    > Sometimes, all you want to do is normalize the expression levels from a set of RNA-Seq libraries so that they're all on the same scale, facilitating downstream analyses such as clustering. Expression levels reported by Cufflinks in FPKM units are usually comparable between samples, but in certain situations, applying an extra level of normalization can remove sources of bias in the data. Cuffnorm normalizes a set of samples to be on as similar scales as possible, which can improve the results you obtain with other downstream tools.  
    

0. Use `Cuffdiff` to find significant changes in expression level.

    From the Cufflinks [manual](http://cole-trapnell-lab.github.io/cufflinks/manual/):
    
    > Comparing expression levels of genes and transcripts in RNA-Seq experiments is a hard problem. Cuffdiff is a highly accurate tool for performing these comparisons, and can tell you not only which genes are up- or down-regulated between two or more conditions, but also which genes are differentially spliced or are undergoing other types of isoform-level regulation.

    0. Omit Tabular Datasets: `No`.
    0. Generate SQLite: `Yes`.
    
0. Use `cummeRbund` to visualize data.

## Data Analysis

0. Download `gene_differential_expression_testing.tabular` (`gene_exp.diff`).

0. Open `gene_differential_expression_testing.tabular` with your favourite spreadsheet software.

    0. Pay attention to correct importing of numerical values (correct decimal delimiter).
    
    0. Filter rows with non-numerical values for fold changes (`-inf` and `inf`).
    
    0. Sort table by `significant` and absolute value of `log2(fold_change)`.
    
        Hint: Insert an extra column that contains absolute exp. values (use the `abs` function).
        
0. Answer the following questions:

    0. Which gene shows the strongest fold change (log scale and linear scale)?
    
    0. Which gene shows the strongest significant fold change (log scale and linear scale)?
    
    0. Which gene shows the weakest fold change (log scale and linear scale)?
    
    0. Which gene shows the weakest significant fold change (log scale and linear scale)?
    
---

[Back to Index](../README.md)

## References

0. [Galaxy Wiki](https://github.com/nekrut/galaxy/wiki)

0. [Galaxy forum](https://biostar.usegalaxy.org/)

0. [FASTQ format#Quality](https://en.wikipedia.org/wiki/FASTQ_format#Quality)

0. [SAM/BAM format](https://samtools.github.io/hts-specs/SAMv1.pdf)

0. Paper [Differential gene and transcript expression analysis of RNA-seq experiments with TopHat and Cufflinks](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3334321)

0. Paper [Analysis of the Human Tissue-specific Expression by Genome-wide Integration of Transcriptomics and Antibody-based Proteomics](http://www.mcponline.org/content/13/2/397)

0. [Cufflinks manual](http://cole-trapnell-lab.github.io/cufflinks/manual/)

0. [CummeRbund manual](http://compbio.mit.edu/cummeRbund/manual_2_0.html)

0. [FPKM explained](http://www.rna-seqblog.com/rpkm-fpkm-and-tpm-clearly-explained/)
