Title: From the Shell and the Cloud - Common Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: ak at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg 2016-01-20 - 2016-01-22

# Bioinformatics Data in the Unix Shell and -Cloud

### Common Bioinformatics Using Unix and Freely Available Open Source Tools on the Example of Gene Expression Analysis

### RNA-Seq (Whole Transcriptome Shotgun Sequencing) using TopHat, Cufflinks, Galaxy and IGV

0. Get familar with your tools.
[Galaxy](https://usegalaxy.org/)

0. Get familiar with your data.
[ENA, Study ERP003613](http://www.ebi.ac.uk/ena/data/view/ERP003613)

0. Load [reference sequence](https://github.com/silico-sciences/bi-seminar/blob/master/3.fa.gz) into Galaxy. It is not necessary to download files on your computer first, Galaxy can get them directly. Just copy the "View Raw" link location from GitHub and paste URLs into the Galaxy upload wizard. In this tutorial we will use chromosome 3 only to save some time and disk space.

    0. Edit data attributes:
        
        0. Change datatype to `fasta`.
        
0. Load [reference annotation](https://github.com/silico-sciences/bi-seminar/blob/master/genes_chr03.gtf.gz) into Galaxy. The annotation should be in [GTF format](http://www.ensembl.org/info/website/upload/gff.html).

0. Load [small data sets](https://github.com/silico-sciences/bi-seminar/tree/master/2014fagerberg-small) into Galaxy. Each tissues was sequenced in four replicates and each replicates has one file for the forward reads (_1.fastq) and reverse reads (_2.fastq).

    0. Edit data attributes:
        
        0. Change datatype to `fastqsanger`.

0. Use `TopHat` to map reads to reference from history (3.fa.gz). TopHat is a splice-aware aligner, so it can handle RNA-Seq data and is able to align reads across introns.

    0. Edit data attributes:
        
        0. Change to `Paired-end (as individual datasets)`.
        
        0. Select forward and reverse reads from each sample.
        

0. Inspect mappings using [IGV](https://www.broadinstitute.org/igv/).

    0. Download mappings `accepted_hits.bam` and it's index file.
    
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

0. [Differential gene and transcript expression analysis of RNA-seq experiments with TopHat and Cufflinks](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3334321/?tool=pmcentrez)

0. [Analysis of the Human Tissue-specific Expression by Genome-wide Integration of Transcriptomics and Antibody-based Proteomics](http://www.mcponline.org/content/13/2/397)

0. [Cufflinks manual](http://cole-trapnell-lab.github.io/cufflinks/manual/)

0. [CummeRbund manual](http://compbio.mit.edu/cummeRbund/manual_2_0.html)
