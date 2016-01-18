Title: The Cloud and the Shell - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: training at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg 2016-01-20 - 2016-01-22

# Applied Bioinformatics in the Cloud and in the Shell

## NGS Data Analysis Using Unix and Open Source Tools

[TOC]

# Data Visualization using RStudio and CummeRbund

Find all data for this section via FTP

ftp://public:public@silico-sciences.com/2014fagerberg

or in this GitHub repository.

[cuffnorm_out](cuffnorm_out)
[cuffdiff_out_lung-heart](cuffdiff_out_lung-heart)
[cuffdiff_out_lung-stomach](cuffdiff_out_lung-stomach)
[cuffdiff_out_stomach-heart](cuffdiff_out_stomach-heart)

## Preparations

0. Install [RStudio](https://www.rstudio.com/).

0. Install the [CummeRbund](http://compbio.mit.edu/cummeRbund/) package.

## Create a Heatmap

0. Download and extract the cuffnorm example data:

    ftp://public@176.28.21.178/2014fagerberg/cuffnorm_out

0. Change your working directory to the `cuffnorm_out` directory.
0. Load `genes.fpkm_table` into R.

        fpkm_table = read.delim("genes.fpkm_table", row.names = 1, header = TRUE, sep="\t")

0. In the heatmap we want to display only genes that show a strong regulation between the samples. Calculate the Mean Absolute Deviation (MAD) of each gene across samples to get the average distance between each data value and the mean. This results in one value per gene identifier.

        > mad_vector = apply(fpkm_table, 1, mad)
        > head(mad_vector)
        ENSG00000001617 ENSG00000003756 ENSG00000004399 ENSG00000004534 ENSG00000004838 ENSG00000007402 
        444.7197       2418.5216        453.4384       2870.0541        599.0401        129.0985
        
0. Sort values descending.

        > mad_vector_sorted = mad_vector[order(mad_vector, decreasing = T)]
        > head(mad_vector_sorted)
        ENSG00000213178 ENSG00000168028 ENSG00000174748 ENSG00000233133 ENSG00000234287 ENSG00000162244 
        60275.17        49332.29        39065.25        31864.41        31546.61        18538.80  
        
0. Extract first 100 elements.

        > mad_top100 =mad_vector_sorted[1:100]  
        
0. Transform table into a matrix.

        fpkm_matrix = as.matrix(fpkm_table)
        > head(fpkm_matrix)
                          lung_0  lung_3    lung_1    lung_2 stomach_0  stomach_1 stomach_2 stomach_3
        ENSG00000001617  683.958    0.00     0.000  261.9730   957.383    99.6764  699.5950   529.600
        ENSG00000003756 1954.310 3010.74  5925.110 3415.3400   152.799  6527.1900    0.0000  2257.020
        ENSG00000004399  137.821    0.00     0.000   98.4343   541.667  2778.8100  611.6800   686.690
        ENSG00000004534 2220.190 6278.09 12119.300 4787.7500  1647.350 10182.6000 1534.9700  1601.320
        ENSG00000004838 3190.500    0.00     0.000  509.9190   808.094     0.0000  421.9870   584.436
        ENSG00000007402  107.916    0.00   375.487    0.0000   210.593     0.0000   66.2355   544.656
        
0. Reduce matrix to top100 regulated gene IDs.

        > fpkm_matrix_100 = fpkm_matrix[names(mad_top100),]
        > head(fpkm_matrix_100)
                         lung_0   lung_3   lung_1   lung_2 stomach_0 stomach_1 stomach_2 stomach_3
        ENSG00000213178 31040.6  41259.4 174005.0 108241.0   7973.69   69963.9   90244.8   8934.71
        ENSG00000168028 35832.5  50029.7 108015.0 113324.0   9335.06  172215.0   33976.2   9978.79
        ENSG00000174748 21576.2  22642.2  73926.2  66054.4   7048.10   65783.0   56496.9   4042.16
        ENSG00000233133 35046.7 104414.0  60632.2  70492.0      0.00   63570.0   27507.5  20941.10
        ENSG00000234287     0.0  11621.1  63999.4  70437.4      0.00   50591.4   22785.0  19770.80
        ENSG00000162244 12915.0  14307.1  59143.2  69294.3  10390.60   31414.3   35399.1   9669.11        
        
0. Perform clustering of samples and genes. 

        > hc = hclust(as.dist(1-cor(fpkm_matrix_100, method="spearman")), method="complete")
        > hr = hclust(as.dist(1-cor(t(fpkm_matrix_100), method="pearson")), method="complete")
        
0. Plot the sample dendrogram. Similar samples will be on the same branch.

        > plot(hc)
        
0. Create the Heatmap. By supplying the sample and gene clusterings the heatmap will be sorted accordingly and dendrograms will be shown.

        > library(heatmap3)
        > heatmap3(fpkm_matrix_100, Rowv=as.dendrogram(hr), Colv=as.dendrogram(hc), scale="row", balanceColor=T, showRowDendro=T, labRow=F, ColSideCut=0.9)
        
       ![pic](../figs/heatmap.png)

## CummeRbund

0. Download and extract the cuffdiff example data.

    0. cuffdiff lung-stomach
       ftp://public:public@176.28.21.178/2014fagerberg/cuffdiff_out_lung-stomach 
    
    0. cuffdiff lung-heart
       ftp://public:public@176.28.21.178/2014fagerberg/cuffdiff_out_lung-heart 
    
    0. cuffdiff stomach-heart
       ftp://public:public@176.28.21.178/2014fagerberg/cuffdiff_out_stomach-heart 

0. Change your working directory to the `cuffdiff_out` directory.
    
0. Load the `cummeRbund` library:

        > library(cummeRbund)
      
0. Read data into `CuffSet` object:

        > cuff = readCufflinks()
        
0. Read genes into `CuffData` object:

        > genes = genes(cuff)

0. Get run information:
    
        > run_info = runInfo(cuff)
        > head(run_info)
                  param   value
        1      cmd_line   cuffdiff -o cuffdiff_out_lung-heart -L Lung,Heart -p8 -b /var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Sequence/Bowtie2Index/genome.fa -u /var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf ERR315424/cuffquant_out/abundances.cxb,ERR315439/cuffquant_out/abundances.cxb,ERR315444/cuffquant_out/abundances.cxb,ERR315487/cuffquant_out/abundances.cxb ERR315328/cuffquant_out/abundances.cxb,ERR315331/cuffquant_out/abundances.cxb,ERR315356/cuffquant_out/abundances.cxb,ERR315367/cuffquant_out/abundances.cxb
        2       version   2.2.1
        3  SVN_revision   4237
        4 boost_version   104700
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
0. Get sample names:
    
        > sample_names = samples(genes)
        > head(sample_names)
        [1] "Lung"    "Heart"

0. Get sample overview:
    
        > replicates = replicates(cuff)
        > replicates
                                            file sample_name replicate rep_name total_mass norm_mass internal_scale external_scale
        1 ERR315424/cuffquant_out/abundances.cxb        Lung         0   Lung_0    5374230   7634370       0.971352              1
        2 ERR315439/cuffquant_out/abundances.cxb        Lung         1   Lung_1    3182170   7634370       0.591422              1
        3 ERR315444/cuffquant_out/abundances.cxb        Lung         2   Lung_2    3237320   7634370       0.607904              1
        4 ERR315487/cuffquant_out/abundances.cxb        Lung         3   Lung_3    8527950   7634370       1.578970              1
        5 ERR315328/cuffquant_out/abundances.cxb       Heart         0  Heart_0   10148500   7634370       0.923755              1
        6 ERR315331/cuffquant_out/abundances.cxb       Heart         1  Heart_1   11510000   7634370       1.223560              1
        7 ERR315356/cuffquant_out/abundances.cxb       Heart         2  Heart_2   12870900   7634370       1.334490              1
        8 ERR315367/cuffquant_out/abundances.cxb       Heart         3  Heart_3   11678700   7634370       1.242760              1

        
0. Get fold changes:
    
        > genes_diff = diffData(genes)
        > head(genes_diff)
                  gene_id sample_1 sample_2 status   value_1   value_2 log2_fold_change test_stat p_value     q_value significant
        1 ENSG00000000003     Lung    Heart     OK 10.236100  6.870980        -0.575075 -0.981730 0.03605 0.076646400          no
        2 ENSG00000000005     Lung    Heart NOTEST  0.146018  0.453053         1.633530  0.000000 1.00000 1.000000000          no
        3 ENSG00000000419     Lung    Heart     OK 20.955000 35.142200         0.745913  0.843148 0.09800 0.173593000          no
        4 ENSG00000000457     Lung    Heart     OK  3.875730  2.869840        -0.433498 -0.530533 0.27440 0.388174000          no
        5 ENSG00000000460     Lung    Heart     OK  1.650870  0.956872        -0.786828 -0.313891 0.29010 0.404409000          no
        6 ENSG00000000938     Lung    Heart     OK 24.990300  1.204640        -4.374690 -4.909090 0.00005 0.000242192         yes
            
0. Order table by significance:     
    
        > genes_diff_sig = genes_diff[order(genes_diff$significant, genes_diff$log2_fold_change, decreasing=T),]
        > head(genes_diff_sig)
                     gene_id sample_1 sample_2 status value_1     value_2 log2_fold_change test_stat p_value     q_value significant
        1480 ENSG00000079393     Lung    Heart     OK       0     9.52368              Inf        NA   5e-05 0.000242192         yes
        2551 ENSG00000101441     Lung    Heart     OK       0     5.70161              Inf        NA   5e-05 0.000242192         yes
        3367 ENSG00000106631     Lung    Heart     OK       0 10737.90000              Inf        NA   5e-05 0.000242192         yes
        3762 ENSG00000109991     Lung    Heart     OK       0     3.20486              Inf        NA   5e-05 0.000242192         yes
        3901 ENSG00000111245     Lung    Heart     OK       0  8726.61000              Inf        NA   5e-05 0.000242192         yes
        4462 ENSG00000115386     Lung    Heart     OK       0     7.58386              Inf        NA   5e-05 0.000242192         yes
    
0. Filter rows where `test_stat` equals `NA`:
    
        > genes_diff_sig_filtered = genes_diff_sig[!is.na(genes_diff_sig$test_stat),]
        > head(genes_diff_sig_filtered)
                      gene_id sample_1 sample_2 status     value_1     value_2 log2_fold_change   test_stat p_value     q_value significant
        40584 ENSG00000241570     Lung    Heart     OK 1.20759e-93     4.32572         310.7800 2.88573e-91 0.00005 0.000242192         yes
        8341  ENSG00000142615     Lung    Heart     OK 4.92158e-84    18.85550         280.9800 2.62871e-81 0.00755 0.020652600         yes
        14026 ENSG00000175206     Lung    Heart     OK 1.45060e-01 30740.00000          17.6931 2.09519e+00 0.01435 0.035571100         yes
        53616 ENSG00000262304     Lung    Heart     OK 4.12227e-05     1.60871          15.2521 1.08576e-02 0.01370 0.034227900         yes
        6249  ENSG00000129991     Lung    Heart     OK 9.85294e-02  2798.30000          14.7936 1.08313e+00 0.00525 0.015194500         yes
        10440 ENSG00000159251     Lung    Heart     OK 2.64974e-01  4840.24000          14.1569 4.99862e+00 0.00005 0.000242192         yes
    
0. Filter to keep ony entries with show a significant regulation:
    
        > genes_diff_sig_filtered2 = genes_diff_sig_filtered[genes_diff_sig_filtered$significant=="yes",]
        > head(genes_diff_sig_filtered2)
                      gene_id sample_1 sample_2 status     value_1     value_2 log2_fold_change   test_stat p_value     q_value significant
        40584 ENSG00000241570     Lung    Heart     OK 1.20759e-93     4.32572         310.7800 2.88573e-91 0.00005 0.000242192         yes
        8341  ENSG00000142615     Lung    Heart     OK 4.92158e-84    18.85550         280.9800 2.62871e-81 0.00755 0.020652600         yes
        14026 ENSG00000175206     Lung    Heart     OK 1.45060e-01 30740.00000          17.6931 2.09519e+00 0.01435 0.035571100         yes
        53616 ENSG00000262304     Lung    Heart     OK 4.12227e-05     1.60871          15.2521 1.08576e-02 0.01370 0.034227900         yes
        6249  ENSG00000129991     Lung    Heart     OK 9.85294e-02  2798.30000          14.7936 1.08313e+00 0.00525 0.015194500         yes
        10440 ENSG00000159251     Lung    Heart     OK 2.64974e-01  4840.24000          14.1569 4.99862e+00 0.00005 0.000242192         yes
    
0. Count number of entries that show a significant regulation:
    
        > nrow(genes_diff_sig_filtered2)
        [1] 6478
            
0. This number is too large to generate a heatmap from it. We therefore reduce this dataset to the top100 regulated genes:
    
    0. Sort by fold change:
    
            > genes_diff_sig_filtered_sorted_abs = genes_diff_sig_filtered2[order(abs(genes_diff_sig_filtered2$log2_fold_change),decreasing=T),] 
            > head(genes_diff_sig_filtered_sorted_abs)
                          gene_id sample_1 sample_2 status     value_1     value_2 log2_fold_change    test_stat p_value     q_value significant
    40584 ENSG00000241570     Lung    Heart     OK 1.20759e-93 4.32572e+00         310.7800  2.88573e-91 0.00005 0.000242192         yes
    8341  ENSG00000142615     Lung    Heart     OK 4.92158e-84 1.88555e+01         280.9800  2.62871e-81 0.00755 0.020652600         yes
    14026 ENSG00000175206     Lung    Heart     OK 1.45060e-01 3.07400e+04          17.6931  2.09519e+00 0.01435 0.035571100         yes
    52339 ENSG00000260908     Lung    Heart     OK 1.26567e+03 1.23424e-02         -16.6459 -1.25322e-01 0.01250 0.031678900         yes
    12516 ENSG00000168484     Lung    Heart     OK 2.03442e+04 3.06545e-01         -16.0182 -2.65728e+00 0.00005 0.000242192         yes
    53616 ENSG00000262304     Lung    Heart     OK 4.12227e-05 1.60871e+00          15.2521  1.08576e-02 0.01370 0.034227900         yes
    
    0. Trimm to top100 entries:
        
            > genes_top100 = genes_diff_sig_filtered_sorted_abs[1:100,]
            > nrow(genes_top100)
            [1] 100
            
            
0. Extract significantly regulated gene IDs:
        
        > gene_ids_top100 = genes_top100[,1]
        > head(gene_ids_top100)
        [1] "ENSG00000241570" "ENSG00000142615" "ENSG00000175206" "ENSG00000260908" "ENSG00000168484" "ENSG00000262304"
            
0. Get gene data for extracted gene IDs:
     
        > genes2 = getGenes(cuff, gene_ids_top100)
        > genes2
        CuffGeneSet instance for  100  genes
        Slots:
              annotation
              fpkm
              repFpkm
              diff
              count
              isoforms	 CuffFeatureSet instance of size 670 
              TSS		 CuffFeatureSet instance of size 570 
              CDS		 CuffFeatureSet instance of size 365 
              promoters		 CuffFeatureSet instance of size 100 
              splicing		 CuffFeatureSet instance of size 570 
              relCDS		 CuffFeatureSet instance of size 100 
         
0. Plot data.

        > csHeatmap(genes2, cluster='both', replicates=T)
            
      ![pic](../figs/csheatmap.png)
          
     
        > expressionBarplot(genes2)
        
    ![pic](../figs/expressionBarplot.png)
           
        > csDistHeat(genes(cuff), replicates=T)
        
       ![pic](../figs/csdistheat.png)
       
        > MDSplot(genes(cuff), replicates=T)
       
       ![pic](../figs/md.png)
       
0. More stuff
       
    0. Get differentially expressed gene identifer:

            > head(diffData(genes(cuff)))
                      gene_id sample_1 sample_2 status   value_1   value_2 log2_fold_change test_stat p_value     q_value significant
            1 ENSG00000000003     Lung    Heart     OK 10.236100  6.870980        -0.575075 -0.981730 0.03605 0.076646400          no
            2 ENSG00000000005     Lung    Heart NOTEST  0.146018  0.453053         1.633530  0.000000 1.00000 1.000000000          no
            3 ENSG00000000419     Lung    Heart     OK 20.955000 35.142200         0.745913  0.843148 0.09800 0.173593000          no
            4 ENSG00000000457     Lung    Heart     OK  3.875730  2.869840        -0.433498 -0.530533 0.27440 0.388174000          no
            5 ENSG00000000460     Lung    Heart     OK  1.650870  0.956872        -0.786828 -0.313891 0.29010 0.404409000          no
            6 ENSG00000000938     Lung    Heart     OK 24.990300  1.204640        -4.374690 -4.909090 0.00005 0.000242192         yes
    
    0. Extract all significant gene identifiers:

            > head(getSig(cuff,alpha=0.05,level="genes"))
            [1] "ENSG00000000938" "ENSG00000000971" "ENSG00000001626" "ENSG00000001630" "ENSG00000002549" "ENSG00000002822"
         
## References

0. [Differential gene and transcript expression analysis of RNA-seq experiments with TopHat and Cufflinks](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3334321/?tool=pmcentrez)

0. [CummeRbund manual](http://compbio.mit.edu/cummeRbund/manual_2_0.html)  
           
