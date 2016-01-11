Title: From the Shell and the Cloud - Common Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: ak at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg 2016-01-20 - 2016-01-22

# Bioinformatics Data in the Unix Shell and -Cloud

### Common Bioinformatics Using Unix and Freely Available Open Source Tools on the Example of Gene Expression Analysis

### RNA-Seq (Whole Transcriptome Shotgun Sequencing) using TopHat, Cufflinks, Galaxy and IGV

0. Get familar with your tools.
[Galaxy](https://bioinf-galaxian.erasmusmc.nl/galaxy/)

0. Get familiar with your data.
[ENA, Study ERP003613](http://www.ebi.ac.uk/ena/data/view/ERP003613)

0. Load [reference sequence](https://github.com/silico-sciences/bi-seminar/blob/master/3.fa.gz) into Galaxy, e.g. by Copy&Paste-ing GitHub URLs into Galaxy upload wizard.

0. Load [reference annotation](https://github.com/silico-sciences/bi-seminar/blob/master/genes_chr03.gtf.gz) into Galaxy.

0. Load [small data sets](https://github.com/silico-sciences/bi-seminar/tree/master/2014fagerberg-small) into Galaxy.

    0. Edit data attributes:
        
        0. Change datatype to `fastqsanger`.

0. Use `TopHat` to map reads to reference from history (3.fa.gz).

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

s
