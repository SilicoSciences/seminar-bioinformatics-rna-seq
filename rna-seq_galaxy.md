Title: The Shell and the Cloud - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: ak at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg 2016-01-20 - 2016-01-22

# Applied Bioinformatics in the Shell and in the Cloud

## NGS Data Analysis Using Unix and Open Source Tools

# RNA-Seq using Galaxy, IGV and the Tuxedo Suite

0. Get familar with your tools.
[Galaxy](https://usegalaxy.org/)

0. Get familiar with your data.
[ENA, Study ERP003613](http://www.ebi.ac.uk/ena/data/view/ERP003613)

    Since NGS data analysis is usually very time consumng, in this tutorial we will use a smaller data set. It has been reduced to chromosome 3 only to save some time and disk space.

0. Load the [reference sequence](https://github.com/SilicoSciences/bi-seminar/blob/master/3.fa.gz?raw=true) into Galaxy. It is not necessary to download files on your computer first, Galaxy can get them directly. Just copy the link above and paste the URLs into the Galaxy upload wizard.

    0. Edit data attributes:
        
        0. Change datatype to `fasta`.
        
0. Load the [reference annotation](https://github.com/SilicoSciences/bi-seminar/blob/master/genes_chr03.gtf.gz?raw=true) into Galaxy. The annotation should be in [GTF format](http://www.ensembl.org/info/website/upload/gff.html).

0. Load [small data sets](https://github.com/silico-sciences/bi-seminar/tree/master/2014fagerberg-small) into Galaxy. Each tissues was sequenced in four replicates and each replicates has one file for the forward reads (`_1.fastq`) and reverse reads (`_2.fastq`).

    0. Edit data attributes:
        
        0. Change datatype to `fastqsanger`.
        
0. Use [FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to take a look at the overall read quality.

    0. Use [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) to trimm the reads.
    
        0. ILLUMINACLIP: TrueSeq3 (paired-ended), 2, 40, 15. 
        0. LEADING: 2
        
        0. TRAILING: 2
        
        0. SLIDINGWINDOW: 4, 2
        
        0. MINLEN: 25
        
0. Compare read quality of trimmed vs. non-trimmed reads.

    0. Lung1: 
    0. Lung2:
    0. Lung1 trimmed:
    0. Lung2 trimmed:

0. Use [TopHat](https://ccb.jhu.edu/software/tophat/index.shtml) to map reads to reference from history (`3.fa.gz`). TopHat is a splice-aware aligner, so it can handle RNA-Seq data and is able to align reads across introns.

    0. Edit data attributes:
        
        0. Change to `Paired-end (as individual datasets)`.
        
        0. Select forward and reverse reads from each sample.

0. Use [IGV](https://www.broadinstitute.org/igv/) to inspect mappings.

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
