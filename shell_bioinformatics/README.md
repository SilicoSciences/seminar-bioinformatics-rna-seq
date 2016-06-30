Title: The Cloud and the Shell - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: training at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg

# Applied Bioinformatics in the Cloud and in the Shell

## RNA-Seq Analysis Using Unix and Open Source Tools 

[TOC]

# The Shell for Bioinformaticians

## Retrieving Data

Find data at

0. UCSC
http://hgdownload.cse.ucsc.edu/goldenPath/

0. Ensembl
http://www.ensembl.org/info/data/ftp/index.html

0. NCBI
ftp://ftp.ncbi.nih.gov/genomes/

0. Illumina
ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/

---

`wget`: the non-interactive network downloader

    $ wget ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Saccharomyces_cerevisiae/Ensembl/EF4/Saccharomyces_cerevisiae_Ensembl_EF4.tar.gz

    $ wget ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/ --accept "*.txt" --recursive --level 1 --no-directories
    
    $ ls -lh
    total 71M
    -rw-r--r-- 1 alex alex  12K Dec 15 00:00 CHANGE_LOG.txt
    -rw-r--r-- 1 alex alex 8,8K Dec 15 00:00 CHECKSUMS.txt
    -rw-r--r-- 1 alex alex 5,3K Jun 17  2014 README.txt
    -rw-r--r-- 1 alex alex  71M Jan 13 14:12 Saccharomyces_cerevisiae_Ensembl_EF4.tar.gz

### Options to remember:

0. `--accept`
0. `--recursive`
0. `--level`
0. `-c`
0. `-q`
0. `-b`
0. `-p`
    
---

## Verifying Data

`md5sum`: compute and check MD5 message digest

`sha1sum`: compute and check SHA1 message digest

    $ echo "bioinfo is fun" | sha1sum 
    3df832201564894a11734910cdb6b53783c7dd24  -
    
    $ echo "bioinfo is fun " | sha1sum 
    0db0ec42650cab76bd2e2cfec2ca1990f6f5a290  -

    $ grep -i "cerevisiae.*ef4" CHECKSUMS.txt 
    0f0dd5c08fe7c988bea990083feb73a7  Saccharomyces_cerevisiae_Ensembl_EF4.tar.gz

    $ md5sum Saccharomyces_cerevisiae_Ensembl_EF4.tar.gz 
    0f0dd5c08fe7c988bea990083feb73a7  Saccharomyces_cerevisiae_Ensembl_EF4.tar.gz

## Compressed Data

`tar`: The GNU version of the tar archiving utility

`gzip`: gzip, gunzip, zcat - compress or expand files

    $ ls
    CHANGE_LOG.txt  CHECKSUMS.txt  README.txt  Saccharomyces_cerevisiae_Ensembl_EF4.tar.gz
    
    $ tar xzf Saccharomyces_cerevisiae_Ensembl_EF4.tar.gz
    
    $ ls
    CHANGE_LOG.txt  CHECKSUMS.txt  README.txt  Saccharomyces_cerevisiae  Saccharomyces_cerevisiae_Ensembl_EF4.tar.gz
    
    $ tree Saccharomyces_cerevisiae -d
    Saccharomyces_cerevisiae
    `-- Ensembl
        `-- EF4
            |-- Annotation
            |   |-- Archives
            |   |   |-- archive-2012-03-09-08-23-05
            |   |   |   |-- Genes
            |   |   |   |-- SmallRNA
            |   |   |   `-- Variation
            |   |   |-- archive-2013-03-06-20-13-33
            |   |   |   |-- Genes
            |   |   |   |-- SmallRNA
            |   |   |   `-- Variation
            |   |   |-- archive-2014-05-23-16-07-50
            |   |   |   `-- Genes
            |   |   |-- archive-2015-07-17-14-36-42
            |   |   |   `-- Genes
            |   |   `-- archive-current -> archive-2015-07-17-14-36-42
            |   `-- Genes -> Archives/archive-current/Genes
            `-- Sequence
                |-- AbundantSequences
                |-- Bowtie2Index
                |-- BowtieIndex
                |-- BWAIndex
                |   |-- version0.5.x
                |   `-- version0.6.0
                |-- Chromosomes
                `-- WholeGenomeFasta

    $ cd Saccharomyces_cerevisiae/Ensembl/EF4/Sequence/WholeGenomeFasta

    $ gzip -c genome.fa > genome.fa.gz

    $ ls -lh genome.fa genome.fa.gz 
    -rwxr-xr-x 1 alex alex  12M Mar 16  2012 genome.fa
    -rw-r--r-- 1 alex alex 3,7M Jan 13 17:25 genome.fa.gz
  
standard    |  compressed
--------|---------
`grep`	| `zgrep`
`less`	| `zless`
`cat`   | `zcat`
`diff`	|`zdiff`

## Inspecting Data

`grep`: grep, egrep, fgrep, rgrep - print lines matching a pattern

     $ grep -c "^>" genome.fa
    17


    $ grep "^>" genome.fa
    >I
    >II
    >III
    >IV
    >IX
    >MT
    >V
    >VI
    >VII
    >VIII
    >X
    >XI
    >XII
    >XIII
    >XIV
    >XV
    >XVI
    
### `head` and `tail`

`head`: output the first part of files

`tail`:  output the last part of files

    $ head genome.fa
    >I
    CCACACCACACCCACACACCCACACACCACACCACACACCACACCACACCCACACACACA
    CATCCTAACACTACCCTAACACAGCCCTAATCTAACCCTGGCCAACCTGTCTCTCAACTT
    ACCCTCCATTACCCTGCCTCCACTCGTTACCCTGTCCCATTCAACCATACCACTCCGAAC
    CACCATCCATCCCTCTACTTACTACCACTCACCCACCGTTACCCTCCAATTACCCATATC
    CAACCCACTGCCACTTACCCTACCATTACCCTACCATCCACCATGACCTACTCACCATAC
    TGTTCTTCTACCCACCATATTGAAACGCTAACAAATGATCGTAAATAACACACACGTGCT
    TACCCTACCACTTTATACCACCACCACATGCCATACTCACCCTCACTTGTATACTGATTT
    TACGTACGCACACGGATGCTACAGTATATACCATCTCAAACTTACCCTACTCTCAGATTC
    CACTTCACTCCATGGCCCATCTCTCACTGAATCAGTACCAAATGCACTCACATCATTATG


    $ head genome.fa -n2
    >I
    CCACACCACACCCACACACCCACACACCACACCACACACCACACCACACCCACACACACA


     $ tail genome.fa -n2
    AGAAGTGTTGTAGGGCTAAAGAACAGGGTTTCATTTTCATTTTTTTTTTTTAATTTCGGT
    CAGAAA
    
    $ (head -n4; tail -n4;) < genome.fa
    >I
    CCACACCACACCCACACACCCACACACCACACCACACACCACACCACACCCACACACACA
    CATCCTAACACTACCCTAACACAGCCCTAATCTAACCCTGGCCAACCTGTCTCTCAACTT
    ACCCTCCATTACCCTGCCTCCACTCGTTACCCTGTCCCATTCAACCATACCACTCCGAAC
    TATAAAAAGTAAACATAAAATAAAGGTAGTAAGTAGCTTTTGGTTGAACATCCGGGTAAG
    AGACAACAGGGCTTGGAGGAGACGTACATGAGGGCTATTTAGGGCTATTTAGGGCTATGT
    AGAAGTGTTGTAGGGCTAAAGAACAGGGTTTCATTTTCATTTTTTTTTTTTAATTTCGGT
    CAGAAA
 
### `more` and `less`

`more`: file perusal filter for crt viewing

`less`: opposite of more

    $ more genome.fa
    
    $ less genome.fa
    
    $ less genome.fa.gz
    "genome.fa.gz" may be a binary file.  See it anyway? 

    $ zless genome.fa.gz
    
Exit `more` and `less` by typing `q`.
    
### `wc`

`wc`: print newline, word, and byte counts for each file

    $ wc genome.fa
    202645   202645 12359807 genome.fa


    $ wc -l genome.fa
    202645 genome.fa

    
    $ wc -l genome.fa genome.dict 
      202645 genome.fa
          18 genome.dict
      202663 total
      
### `cut`

    $ cd ../../Annotation/Genes

    $ head genes.gtf -n1
    I	protein_coding	CDS	335	646	.	+	0	exon_number "1"; gene_id "YAL069W"; gene_name "YAL069W"; p_id "P3634"; protein_id "YAL069W"; transcript_id "YAL069W"; transcript_name "YAL069W"; tss_id "TSS1128";

`cut`: remove sections from each line of files

    $ cut -f 1,4,5 genes.gtf | head -n4
    I	335	646
    I	335	649
    I	335	337
    I	538	789

### `column`
    
`column`: columnate lists

    $ cut -f 1-8 genes.gtf | head -n4
    I	protein_coding	CDS	335	646	.	+	0
    I	protein_coding	exon	335	649	.	+	.
    I	protein_coding	start_codon	335	337	.	+	0
    I	protein_coding	CDS	538	789	.	+	0

    $ cut -f 1-8 genes.gtf | head -n4 | column -t
    I  protein_coding  CDS          335  646  .  +  0
    I  protein_coding  exon         335  649  .  +  .
    I  protein_coding  start_codon  335  337  .  +  0
    I  protein_coding  CDS          538  789  .  +  0
 
### `grep`

`grep`: grep, egrep, fgrep, rgrep - print lines matching a pattern

    $ grep "CUP" genes.gtf | column -t
    VII   protein_coding  CDS          191129  191803  .  +  0  exon_number  "1";  gene_id  "YGL166W";  gene_name  "CUP2";    p_id  "P3542";  protein_id     "YGL166W";  transcript_id    "YGL166W";  transcript_name  "CUP2";     tss_id  "TSS2289";
    VII   protein_coding  exon         191129  191806  .  +  .  exon_number  "1";  gene_id  "YGL166W";  gene_name  "CUP2";    p_id  "P3542";  seqedit        "false";    transcript_id    "YGL166W";  transcript_name  "CUP2";     tss_id  "TSS2289";
    [..]
    XVI   protein_coding  CDS          213045  213962  .  -  0  exon_number  "1";  gene_id  "YPL177C";  gene_name  "CUP9";    p_id  "P3680";  protein_id     "YPL177C";  transcript_id    "YPL177C";  transcript_name  "CUP9";     tss_id  "TSS6047";
    XVI   protein_coding  start_codon  213960  213962  .  -  0  exon_number  "1";  gene_id  "YPL177C";  gene_name  "CUP9";    p_id  "P3680";  transcript_id  "YPL177C";  transcript_name  "CUP9";     tss_id           "TSS6047";
    
#### Exclude some matches

     $ grep "CUP" genes.gtf | grep -v "CUP[2-9]" | column -t
    VIII  protein_coding  exon         212535  212720  .  -  .  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  seqedit        "false";    transcript_id    "YHR053C";  transcript_name  "CUP1-1";   tss_id  "TSS1005";
    VIII  protein_coding  stop_codon   212535  212537  .  -  0  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  transcript_id  "YHR053C";  transcript_name  "CUP1-1";   tss_id           "TSS1005";
    VIII  protein_coding  CDS          212538  212720  .  -  0  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  protein_id     "YHR053C";  transcript_id    "YHR053C";  transcript_name  "CUP1-1";   tss_id  "TSS1005";
    VIII  protein_coding  start_codon  212718  212720  .  -  0  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  transcript_id  "YHR053C";  transcript_name  "CUP1-1";   tss_id           "TSS1005";
    VIII  protein_coding  exon         214533  214718  .  -  .  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  seqedit        "false";    transcript_id    "YHR055C";  transcript_name  "CUP1-2";   tss_id  "TSS2912";
    VIII  protein_coding  stop_codon   214533  214535  .  -  0  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  transcript_id  "YHR055C";  transcript_name  "CUP1-2";   tss_id           "TSS2912";
    VIII  protein_coding  CDS          214536  214718  .  -  0  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  protein_id     "YHR055C";  transcript_id    "YHR055C";  transcript_name  "CUP1-2";   tss_id  "TSS2912";
    VIII  protein_coding  start_codon  214716  214718  .  -  0  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  transcript_id  "YHR055C";  transcript_name  "CUP1-2";   tss_id           "TSS2912";

#### Print some lines before and after each match

    $ grep -B2 -A2 "CUP1-1" genes.gtf | column -t
    VIII  protein_coding  exon         212510  212704  .  +  .  exon_number  "1";  gene_id  "YHR052W-A";  gene_name  "YHR052W-A";  p_id  "P3063";  seqedit        "false";      transcript_id    "YHR052W-A";  transcript_name  "YHR052W-A";  tss_id  "TSS5233";
    VIII  protein_coding  start_codon  212510  212512  .  +  0  exon_number  "1";  gene_id  "YHR052W-A";  gene_name  "YHR052W-A";  p_id  "P3063";  transcript_id  "YHR052W-A";  transcript_name  "YHR052W-A";  tss_id           "TSS5233";
    VIII  protein_coding  exon         212535  212720  .  -  .  exon_number  "1";  gene_id  "YHR053C";    gene_name  "CUP1-1";     p_id  "P3710";  seqedit        "false";      transcript_id    "YHR053C";    transcript_name  "CUP1-1";     tss_id  "TSS1005";
    VIII  protein_coding  stop_codon   212535  212537  .  -  0  exon_number  "1";  gene_id  "YHR053C";    gene_name  "CUP1-1";     p_id  "P3710";  transcript_id  "YHR053C";    transcript_name  "CUP1-1";     tss_id           "TSS1005";
    VIII  protein_coding  CDS          212538  212720  .  -  0  exon_number  "1";  gene_id  "YHR053C";    gene_name  "CUP1-1";     p_id  "P3710";  protein_id     "YHR053C";    transcript_id    "YHR053C";    transcript_name  "CUP1-1";     tss_id  "TSS1005";
    VIII  protein_coding  stop_codon   212702  212704  .  +  0  exon_number  "1";  gene_id  "YHR052W-A";  gene_name  "YHR052W-A";  p_id  "P3063";  transcript_id  "YHR052W-A";  transcript_name  "YHR052W-A";  tss_id           "TSS5233";
    VIII  protein_coding  start_codon  212718  212720  .  -  0  exon_number  "1";  gene_id  "YHR053C";    gene_name  "CUP1-1";     p_id  "P3710";  transcript_id  "YHR053C";    transcript_name  "CUP1-1";     tss_id           "TSS1005";
    VIII  protein_coding  exon         213185  214249  .  -  .  exon_number  "1";  gene_id  "YHR054C";    gene_name  "YHR054C";    p_id  "P3463";  seqedit        "false";      transcript_id    "YHR054C";    transcript_name  "YHR054C";    tss_id  "TSS4009";
    VIII  protein_coding  stop_codon   213185  213187  .  -  0  exon_number  "1";  gene_id  "YHR054C";    gene_name  "YHR054C";    p_id  "P3463";  transcript_id  "YHR054C";    transcript_name  "YHR054C";    tss_id           "TSS4009";
    
#### grep a range of matches
  
    $ grep "CUP1-[1,2]" genes.gtf | column -t
    VIII  protein_coding  exon         212535  212720  .  -  .  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  seqedit        "false";    transcript_id    "YHR053C";  transcript_name  "CUP1-1";   tss_id  "TSS1005";
    VIII  protein_coding  stop_codon   212535  212537  .  -  0  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  transcript_id  "YHR053C";  transcript_name  "CUP1-1";   tss_id           "TSS1005";
    VIII  protein_coding  CDS          212538  212720  .  -  0  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  protein_id     "YHR053C";  transcript_id    "YHR053C";  transcript_name  "CUP1-1";   tss_id  "TSS1005";
    VIII  protein_coding  start_codon  212718  212720  .  -  0  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  transcript_id  "YHR053C";  transcript_name  "CUP1-1";   tss_id           "TSS1005";
    VIII  protein_coding  exon         214533  214718  .  -  .  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  seqedit        "false";    transcript_id    "YHR055C";  transcript_name  "CUP1-2";   tss_id  "TSS2912";
    VIII  protein_coding  stop_codon   214533  214535  .  -  0  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  transcript_id  "YHR055C";  transcript_name  "CUP1-2";   tss_id           "TSS2912";
    VIII  protein_coding  CDS          214536  214718  .  -  0  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  protein_id     "YHR055C";  transcript_id    "YHR055C";  transcript_name  "CUP1-2";   tss_id  "TSS2912";
    VIII  protein_coding  start_codon  214716  214718  .  -  0  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  transcript_id  "YHR055C";  transcript_name  "CUP1-2";   tss_id           "TSS2912";

#### Extended regular expressions

     $ grep -E "(CUP1-1|CUP1-2)" genes.gtf | column -t
    VIII  protein_coding  exon         212535  212720  .  -  .  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  seqedit        "false";    transcript_id    "YHR053C";  transcript_name  "CUP1-1";   tss_id  "TSS1005";
    VIII  protein_coding  stop_codon   212535  212537  .  -  0  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  transcript_id  "YHR053C";  transcript_name  "CUP1-1";   tss_id           "TSS1005";
    VIII  protein_coding  CDS          212538  212720  .  -  0  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  protein_id     "YHR053C";  transcript_id    "YHR053C";  transcript_name  "CUP1-1";   tss_id  "TSS1005";
    VIII  protein_coding  start_codon  212718  212720  .  -  0  exon_number  "1";  gene_id  "YHR053C";  gene_name  "CUP1-1";  p_id  "P3710";  transcript_id  "YHR053C";  transcript_name  "CUP1-1";   tss_id           "TSS1005";
    VIII  protein_coding  exon         214533  214718  .  -  .  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  seqedit        "false";    transcript_id    "YHR055C";  transcript_name  "CUP1-2";   tss_id  "TSS2912";
    VIII  protein_coding  stop_codon   214533  214535  .  -  0  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  transcript_id  "YHR055C";  transcript_name  "CUP1-2";   tss_id           "TSS2912";
    VIII  protein_coding  CDS          214536  214718  .  -  0  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  protein_id     "YHR055C";  transcript_id    "YHR055C";  transcript_name  "CUP1-2";   tss_id  "TSS2912";
    VIII  protein_coding  start_codon  214716  214718  .  -  0  exon_number  "1";  gene_id  "YHR055C";  gene_name  "CUP1-2";  p_id  "P3653";  transcript_id  "YHR055C";  transcript_name  "CUP1-2";   tss_id           "TSS2912";

### `sort` and `uniq`

`sort`: sort lines of text files

    $ cat example.bed 
    chr1	26	39
    chr1	32	47
    chr3	11	28
    chr1	40	49
    chr3	16	27
    chr1	9	28
    chr2	35	54
    chr1	10	19

    $ sort example.bed 
    chr1	10	19
    chr1	26	39
    chr1	32	47
    chr1	40	49
    chr1	9	28
    chr2	35	54
    chr3	11	28
    chr3	16	27

#### Specify columns to sort by (*sorting keys*)

You can/ must specify a range of columns.

Default sorting is alphanumerical, using `-n` changes sorting to numerical.

    $ sort -k1,1 -k2,2n example.bed 
    chr1	9	28
    chr1	10	19
    chr1	26	39
    chr1	32	47
    chr1	40	49
    chr2	35	54
    chr3	11	28
    chr3	16	27
    
#### `-r` can be used for reverse ordering.
    
    $ sort -k1,1 -k2,2n example.bed 
    chr3	11	28
    chr3	16	27
    chr2	35	54
    chr1	9	28
    chr1	10	19
    chr1	26	39
    chr1	32	47
    chr1	40	49
    
    $ sort -k1,1 -k2,2nr example.bed 
    chr1	40	49
    chr1	32	47
    chr1	26	39
    chr1	10	19
    chr1	9	28
    chr2	35	54
    chr3	16	27
    chr3	11	28
    
#### Use `-V` for natural sort of numbers within text.
    
    $ sort -k1,1 -k2,2n example2.bed 
    chr1	34	49
    chr10	30	42
    chr10	31	47
    chr11	6	16
    chr2	15	19
    chr2	17	22
    chr2	27	46
    chr22	32	46

    $ sort -k1,1V -k2,2n example2.bed 
    chr1	34	49
    chr2	15	19
    chr2	17	22
    chr2	27	46
    chr10	30	42
    chr10	31	47
    chr11	6	16
    chr22	32	46

#### 'De-sort'

    sort -R genes.gtf > genes_random.gtf
    
#### Use `-s` to stabilize sorting by disabling last-resort comparison
    
    sort -k1,1 -k4,4n -s genes_random.gtf > genes_sorted.gtf
    
    $ sort -k1,1 -k4,4n -c genes_sorted.gtf
    sort: genes_sorted.gtf:3: disorder: I	protein_coding	exon	335	649	.	+	.	exon_number "1"; gene_id "YAL069W"; gene_name "YAL069W"; p_id "P3634"; seqedit "false"; transcript_id "YAL069W"; transcript_name "YAL069W"; tss_id "TSS1128";

    $ echo $?
    1

    $ sort -k1,1 -k4,4n -c -s genes_sorted.gtf

    $ echo $?
    0

### `uniq`

`uniq`: report or omit repeated lines

    $ cat letters.txt 
    A
    A
    B
    C
    B
    C
    C
    C

    $ uniq letters.txt 
    A
    B
    C
    B
    C

    $ sort letters.txt | uniq
    A
    B
    C
    
#### Use `-c` to prefix lines by the numer of occurrences
    
    $ uniq -c letters.txt 
    2 A
    1 B
    1 C
    1 B
    3 C

    $ sort letters.txt | uniq -c
    2 A
    2 B
    4 C
    
### Combine tools for mini statistics

Display the numbers of distinct features in a GTF file
    
    $ cut -f3 genes.gtf | sort | uniq -c
    7050 CDS
    7553 exon
    6694 start_codon
    6692 stop_codon
    
Order results by total numbers

    $ cut -f3 genes.gtf | sort | uniq -c | sort -r
    7553 exon
    7050 CDS
    6694 start_codon
    6692 stop_codon
    
Show total number of features and corresponding strand

    $ cut -f3,7 genes.gtf | sort | uniq -c | sort -r | column -t
    3868  exon         +
    3685  exon         -
    3586  CDS          +
    3464  CDS          -
    3385  stop_codon   +
    3384  start_codon  +
    3310  start_codon  -
    3307  stop_codon   -

Show total number of features for a specific gene

    $ grep "TIM12" genes.gtf | cut -f3 | sort | uniq -c
    1 CDS
    1 exon
    1 start_codon
    1 stop_codon

### `awk`

`awk`: pattern scanning and processing language

#### Mimic `cat` and print the complete record

    $ awk '{print $0}' example.bed 
    chr1	26	39
    chr1	32	47
    chr3	11	28
    chr1	40	49
    chr3	16	27
    chr1	9	28
    chr2	35	54
    chr1	10	19
    
#### Mimic `cut`

    $ awk '{print $2 "\t" $3}' example.bed 
    26	39
    32	47
    11	28
    40	49
    16	27
    9	28
    35	54
    10	19
    
#### Arithmetic with standard operators 

    $ awk '$3 - $2 > 18' example.bed 
    chr1	9	28
    chr2	35	54
    
#### Regular expressions and logical operators (AND `&&`, OR `||`)
    
    $ awk '$1 ~ /chr1/ && $3 - $2 > 10' example.bed 
    chr1	26	39
    chr1	32	47
    chr1	9	28
 
#### Inverse RegEx
 
    $ awk '$1 !~ /chr1/ && $3 - $2 > 10' example.bed 
    chr3	11	28
    chr3	16	27
    chr2	35	54
    
#### Add a column with the length of the feature for chr2 and chr3

    $ awk '$1 ~/chr2|chr3/ {print $0 "\t" $3 -$2}' example.bed
    chr3	11	28	17
    chr3	16	27	11
    chr2	35	54	19

#### Calculate the mean feature length

keyword | meaining
--------|---------
`BEGIN` | Specifies what to do before reading the first record
`END` | Specifies what to do after the last record
`NR` | Total number of records

    $ awk 'BEGIN{ s=0 }; { s += ($3-$2) }; END{ print "mean: " s/NR };' example.bed
    mean: 14  

#### Convert CSV to tab-delimited

keyword | meaining
--------|---------
`F` | Field separator
`OFS` | Output field separator

    $ awk -F"," -vOFS="\t" { print $1,$2,$3} my.csv

#### Using <i>associative arrays</i> to count the number of features for the gene <i>TIM12</i>

    $ awk '/"TIM12"/ {feature[$3] +=1 }; END {for (k in feature) print k "\t" feature[k] }' genes.gtf
    exon	1
    CDS	1
    start_codon	1
    stop_codon	1
    
### `bioawk`

    $ bioawk -c help
    bed:
	1:chrom 2:start 3:end 4:name 5:score 6:strand 7:thickstart 8:thickend 9:rgb 10:blockcount 11:blocksizes 12:blockstarts 
    sam:
	1:qname 2:flag 3:rname 4:pos 5:mapq 6:cigar 7:rnext 8:pnext 9:tlen 10:seq 11:qual 
    vcf:
	1:chrom 2:pos 3:id 4:ref 5:alt 6:qual 7:filter 8:info 
    gff:
	1:seqname 2:source 3:feature 4:start 5:end 6:score 7:filter 8:strand 9:group 10:attribute 
    fastx:
	1:name 2:seq 3:qual 4:comment
	
#### Get the number of entries in a fastq file

    $ bioawk -c fastx 'END {print NR}' genome.fa
    17
    
#### Get chromosome lengths

    $ bioawk -c fastx '{print $name, length($seq)}' genome.fa | column -t
    I     230218
    II    813184
    III   316620
    IV    1531933
    IX    439888
    MT    85779
    V     576874
    VI    270161
    VII   1090940
    VIII  562643
    X     745751
    XI    666816
    XII   1078177
    XIII  924431
    XIV   784333
    XV    1091291
    XVI   948066

### `sed`

`sed`: stream editor for filtering and transforming text

    $ cat genes.gtf | head -n1
    I	protein_coding	CDS	335	646	.	+	0	exon_number "1"; gene_id "YAL069W"; gene_name "YAL069W"; p_id "P3634"; protein_id "YAL069W"; transcript_id "YAL069W"; transcript_name "YAL069W"; tss_id "TSS1128";
    
#### Stream substitution

    $ sed 's/I/1/' genes.gtf | head -n1
    1	protein_coding	CDS	335	646	.	+	0	exon_number "1"; gene_id "YAL069W"; gene_name "YAL069W"; p_id "P3634"; protein_id "YAL069W"; transcript_id "YAL069W"; transcript_name "YAL069W"; tss_id "TSS1128";


##### RegEx groups

    $ echo "chrI:3747-3909" | sed -E 's/^(chr[^:]+):([0-9]+)-([0-9]+)/\1\t\2\t\3/'
    chrI	3747	3909

#### Ranges of lines

    $ sed -n '1,4p' genes.gtf
    chrI	unknown	exon	3747	3909	.	-	.	gene_id "Y74C9A.6"; gene_name "Y74C9A.6"; transcript_id "NR_001477"; tss_id "TSS32524";
    chrI	unknown	exon	4221	4358	.	-	.	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";
    chrI	unknown	stop_codon	4221	4223	.	-	.	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";
    chrI	unknown	CDS	4224	4358	.	-	0	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";

    $ sed -n '20,24p' genes.gtf 
    I	protein_coding	start_codon	9014	9016	.	-	0	exon_number "1"; gene_id "YAL067C"; gene_name "SEO1"; p_id "P3192"; transcript_id "YAL067C"; transcript_name "SEO1"; tss_id "TSS5470";
    I	protein_coding	CDS	10091	10396	.	+	0	exon_number "1"; gene_id "YAL066W"; gene_name "YAL066W"; p_id "P826"; protein_id "YAL066W"; transcript_id "YAL066W"; transcript_name "YAL066W"; tss_id "TSS2667";
    I	protein_coding	exon	10091	10399	.	+	.	exon_number "1"; gene_id "YAL066W"; gene_name "YAL066W"; p_id "P826"; seqedit "false"; transcript_id "YAL066W"; transcript_name "YAL066W"; tss_id "TSS2667";
    I	protein_coding	start_codon	10091	10093	.	+	0	exon_number "1"; gene_id "YAL066W"; gene_name "YAL066W"; p_id "P826"; transcript_id "YAL066W"; transcript_name "YAL066W"; tss_id "TSS2667";
    I	protein_coding	stop_codon	10397	10399	.	+	0	exon_number "1"; gene_id "YAL066W"; gene_name "YAL066W"; p_id "P826"; transcript_id "YAL066W"; transcript_name "YAL066W"; tss_id "TSS2667";

![note](../figs/note_20x20.png) Like `grep`, `sed` uses per default *POSIX Basic regular Expressions (BRE)*.
Like `grep`, you can use `-E` to switch to *POSIX Extended regular Expressions (ERE)* 

![note](../figs/note_20x20.png) Per default, `sed` replaces only the **first occurrence** of a match. To replace all occurrences, use the *global* flag:
`sed s/pattern/replacement/g`

---

[Back to Index](../README.md)
