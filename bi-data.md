Title: From the Shell and the Cloud - Common Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: ak at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg 2016-01-20 - 2016-01-22

# Bioinformatics Data in the Shell and -Cloud

### Common Bioinformatics Using Unix and Freely Available Open Source Tools on the Example of Gene Expression Analysis

# Working with Bioinformatics Data

### Retrieving Data

Find data at

0. UCSC
`http://hgdownload.cse.ucsc.edu/goldenPath/`

0. Ensembl
`http://www.ensembl.org/info/data/ftp/index.html`

0. NCBI

---

`wget`: the non-interactive network downloader

    $ wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr22.fa.gz http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/md5sum.txt

#### Options to remember:

0. `--accept`
0. `--no-directories`
0. `--recursive`
0. `-c`
0. `-q`
0. `-b`
0. `-p`


---

`rsync`:  a fast, versatile, remote (and local) file-copying tool

*Trailing slashes (data vs data/) matter! No slash meains rsync the folder, slash means rsync content. Forgetting the slash can e.g. result in data/data/... instead of data/....*

---

### Filesizes

    $ ls -lh
    total 11M
    -rw-r--r-- 1 alex alex  11M Mar 20  2009 chr22.fa.gz
    -rw-r--r-- 1 alex alex 4,9K Mar 20  2009 md5sum.txt
    
---

### Verifying Data

`md5sum`: compute and check MD5 message digest

`sha1sum`: compute and check SHA1 message digest

    $ echo "bioinfo is fun" | sha1sum 
    3df832201564894a11734910cdb6b53783c7dd24  -
    
    $ echo "bioinfo is fun " | sha1sum 
    0db0ec42650cab76bd2e2cfec2ca1990f6f5a290  -

    $ grep "chr22" md5sum.txt 
    2baab477ebcc5a0f4163608ec93e4744  chr22.fa.gz

    $ md5sum chr22.fa.gz 
    2baab477ebcc5a0f4163608ec93e4744  chr22.fa.gz

    $ sha1sum chr22.fa.gz 
    d012edd46f50d674380460d3b4e91f450688e756  chr22.fa.gz
    
    $ md5sum -c md5sum.txt 
    [..]
    chr21_gl000210_random.fa.gz: FAILED open or read
    chr22.fa.gz: OK
    md5sum: chr3.fa.gz: No such file or directory
    [..]

### Compressed Data

`gzip`: gzip, gunzip, zcat - compress or expand files

`tar`: The GNU version of the tar archiving utility

    $ ls -lh
    total 11M
    -rw-r--r-- 1 alex alex  11M Mar 20  2009 chr22.fa.gz
    -rw-r--r-- 1 alex alex 4,9K Mar 20  2009 md5sum.txt
  
    $ gunzip chr22.fa.gz 
    
    $ ls -lh
    total 50M
    -rw-r--r-- 1 alex alex  50M Mar 20  2009 chr22.fa
    -rw-r--r-- 1 alex alex 4,9K Mar 20  2009 md5sum.txt
    
    $ gzip chr22.fa
    
    $ ls -lh
    total 11M
    -rw-r--r-- 1 alex alex  11M Mar 20  2009 chr22.fa.gz
    -rw-r--r-- 1 alex alex 4,9K Mar 20  2009 md5sum.txt
    
standard    |  compressed
--------|---------
`grep`	| `zgrep`
`less`	| `zless`
`cat`   | `zcat`
`diff`	|`zdiff`

### Inspecting Data

    $ pwd
    /home/bi/Caenorhabditis_elegans/UCSC/ce10/Sequence/WholeGenomeFasta/
    
---

    $ ls -lh
    total 98M
    -rwxrwxr-x 1 bi bi 1,2K Jun 10  2014 genome.dict
    -rwxrwxr-x 1 bi bi  98M Jun 16 18:24 genome.fa
    -rwxrwxr-x 1 bi bi  197 Jun 10  2014 genome.fa.fai
    -rwxrwxr-x 1 bi bi 1,3K Jun 10  2014 GenomeSize.xml
    
#### `head` and `tail`

    $ head genome.fa
    >chrI
    gcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagc
    ctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcct
    aagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaa
    gcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagc
    ctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcct
    aagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaa
    gcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagc
    ctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcct
    aagcctaagcctaagcctaagcctaagcctaaAAAATTGAGATAAGAAAA
    
    $ head genome.fa -n20
    >chrI
    gcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagc
    ctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcct
    aagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaa
    gcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagc
    ctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcct
    aagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaa
    gcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagc
    ctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcct
    aagcctaagcctaagcctaagcctaagcctaaAAAATTGAGATAAGAAAA
    CATTTTACTTTTTCAAAATTGTTTTCATGCTAAATTCAAAACGTTTTTTT
    TTTAGTGAAGCTTCTAGATATTTGGCGGGTACCTCTAATTTTGCCTGCCT
    GCCAACCTATATGCTCCTGTGTTtaggcctaatactaagcctaagcctaa
    gcctaatactaagcctaagcctaagactaagcctaatactaagcctaagc
    ctaagactaagcctaagactaagcctaagactaagcctaatactaagcct
    aagcctaagactaagcctaagcctaatactaagcctaagcctaagactaa
    gcctaatactaagcctaagcctaagactaagcctaagactaagcctaaga
    ctaagcctaatactaagcctaagcctaagactaagcctaagcctaaAAGA
    ATATGGTAGCTACAGAAACGGTAGTACACTCTTCTGAAAATACAAAAAAT
    TTGCAATTTTTATAGCTAGGGCACTTTTTGTCTGCCCAAATATAGGCAAC

    $ tail genome.fa
    GATTCTCGGAGAACTTGCCGCACCATTCCGCCTTGTGTTCATTGCTGCCT
    GCATGTTCATTGTCTACCTCGGCTACGTGTGGCTATCTTTCCTCGGTGCC
    CTCGTGCACGGAGTCGAGAAACCAAAGAACAAAAAAAGAAATTAAAATAT
    TTATTTTGCTGTGGTTTTTGATGTGTGTTTTTTATAATGATTTTTGATGT
    GACCAATTGTACTTTTCCTTTAAATGAAATGTAATCTTAAATGTATTTCC
    GACGAATTCGAGGCCTGAAAAGTGTGACGCCATTCGTATTTGATTTGGGT
    TTACTATCGAATAATGAGAATTTTCaggcttaggcttaggcttaggctta
    ggcttaggcttaggcttaggcttaggcttaggcttaggcttaggcttagg
    cttaggcttaggcttaggcttaggcttaggcttaggcttaggcttaggct
    taggcttaggcttagg
    
    $ (head; tail) < genome.fa
    >chrI
    gcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagc
    ctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcct
    aagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaa
    gcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagc
    ctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcct
    aagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaa
    gcctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagc
    ctaagcctaagcctaagcctaagcctaagcctaagcctaagcctaagcct
    aagcctaagcctaagcctaagcctaagcctaaAAAATTGAGATAAGAAAA
    GATTCTCGGAGAACTTGCCGCACCATTCCGCCTTGTGTTCATTGCTGCCT
    GCATGTTCATTGTCTACCTCGGCTACGTGTGGCTATCTTTCCTCGGTGCC
    CTCGTGCACGGAGTCGAGAAACCAAAGAACAAAAAAAGAAATTAAAATAT
    TTATTTTGCTGTGGTTTTTGATGTGTGTTTTTTATAATGATTTTTGATGT
    GACCAATTGTACTTTTCCTTTAAATGAAATGTAATCTTAAATGTATTTCC
    GACGAATTCGAGGCCTGAAAAGTGTGACGCCATTCGTATTTGATTTGGGT
    TTACTATCGAATAATGAGAATTTTCaggcttaggcttaggcttaggctta
    ggcttaggcttaggcttaggcttaggcttaggcttaggcttaggcttagg
    cttaggcttaggcttaggcttaggcttaggcttaggcttaggcttaggct
    taggcttaggcttagg

#### `grep`

    $ grep -c "^>" genome.fa
    7

    $ grep ">chr" genome.fa
    >chrI
    >chrII
    >chrIII
    >chrIV
    >chrM
    >chrV
    >chrX
    
---

    $ more genome.fa
    
    $ less genome.fa
    
---

    $ wc genome.fa
    2005730   2005730 102291839 genome.fa
    
    $ wc -l genome.fa
    2005730 genome.fa
    
    $ wc -l genome.fa genome.dict 
    2005730 genome.fa
          8 genome.dict
    2005738 total

---

    $ cd Caenorhabditis_elegans/UCSC/ce10/Sequence/WholeGenomeFasta/
    
---

`cut`: remove sections from each line of files

`man cut`

    $ cut -f 1,4,5 genes.gtf | head -n4
    chrI	3747	3909
    chrI	4221	4358
    chrI	4221	4223
    chrI	4224	4358

    cut -f 1,4,5 genes.gtf > test.txt
    
`column`: columnate lists

`man column`

    $ cut -f1-8 genes.gtf | head -n4
    chrI	unknown	exon	3747	3909	.	-	.
    chrI	unknown	exon	4221	4358	.	-	.
    chrI	unknown	stop_codon	4221	4223	.	-	.
    chrI	unknown	CDS	4224	4358	.	-	0
    
    $ cut -f1-8 genes.gtf | head -n4 | column -t
    chrI  unknown  exon        3747  3909  .  -  .
    chrI  unknown  exon        4221  4358  .  -  .
    chrI  unknown  stop_codon  4221  4223  .  -  .
    chrI  unknown  CDS         4224  4358  .  -  0
    
---

`grep`: grep, egrep, fgrep, rgrep - print lines matching a pattern

`man grep`

    $ grep "psf-3" genes.gtf | head -n4 | column -t
    chrI  unknown  CDS          534461  534572  .  +  0  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  exon         534461  534572  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  start_codon  534461  534463  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  CDS          534621  534727  .  +  2  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";

     $ grep "psf-3" genes.gtf | grep -v "cpsf" | column -t
    chrI  unknown  CDS          534461  534572  .  +  0  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  exon         534461  534572  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  start_codon  534461  534463  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  CDS          534621  534727  .  +  2  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  exon         534621  534727  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  CDS          534775  534973  .  +  0  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  exon         534775  534973  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  CDS          535034  535194  .  +  2  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  exon         535034  535197  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  stop_codon   535195  535197  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";

    $ grep -w "psf-3" genes.gtf | column -t
    chrI  unknown  CDS          534461  534572  .  +  0  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  exon         534461  534572  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  start_codon  534461  534463  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  CDS          534621  534727  .  +  2  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  exon         534621  534727  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  CDS          534775  534973  .  +  0  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  exon         534775  534973  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  CDS          535034  535194  .  +  2  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  exon         535034  535197  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI  unknown  stop_codon   535195  535197  .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";  transcript_id  "NM_058347";  tss_id  "TSS44728";
    
     $ grep -w -B2 -A2 "psf-3" genes.gtf | column -t
    chrI  unknown  stop_codon   532853  532855  .  +  .  gene_id  "Y65B4BL.1";  gene_name  "Y65B4BL.1";  p_id           "P22176";     transcript_id  "NM_001306348";  tss_id  "TSS25017";
    chrI  unknown  exon         532971  533042  .  +  .  gene_id  "Y65B4BM.2";  gene_name  "Y65B4BM.2";  transcript_id  "NR_101514";  tss_id         "TSS45673";
    chrI  unknown  CDS          534461  534572  .  +  0  gene_id  "psf-3";      gene_name  "psf-3";      p_id           "P6191";      transcript_id  "NM_058347";     tss_id  "TSS44728";
    chrI  unknown  exon         534461  534572  .  +  .  gene_id  "psf-3";      gene_name  "psf-3";      p_id           "P6191";      transcript_id  "NM_058347";     tss_id  "TSS44728";
    chrI  unknown  start_codon  534461  534463  .  +  .  gene_id  "psf-3";      gene_name  "psf-3";      p_id           "P6191";      transcript_id  "NM_058347";     tss_id  "TSS44728";
    chrI  unknown  CDS          534621  534727  .  +  2  gene_id  "psf-3";      gene_name  "psf-3";      p_id           "P6191";      transcript_id  "NM_058347";     tss_id  "TSS44728";
    chrI  unknown  exon         534621  534727  .  +  .  gene_id  "psf-3";      gene_name  "psf-3";      p_id           "P6191";      transcript_id  "NM_058347";     tss_id  "TSS44728";
    chrI  unknown  CDS          534775  534973  .  +  0  gene_id  "psf-3";      gene_name  "psf-3";      p_id           "P6191";      transcript_id  "NM_058347";     tss_id  "TSS44728";
    chrI  unknown  exon         534775  534973  .  +  .  gene_id  "psf-3";      gene_name  "psf-3";      p_id           "P6191";      transcript_id  "NM_058347";     tss_id  "TSS44728";
    chrI  unknown  CDS          535034  535194  .  +  2  gene_id  "psf-3";      gene_name  "psf-3";      p_id           "P6191";      transcript_id  "NM_058347";     tss_id  "TSS44728";
    chrI  unknown  exon         535034  535197  .  +  .  gene_id  "psf-3";      gene_name  "psf-3";      p_id           "P6191";      transcript_id  "NM_058347";     tss_id  "TSS44728";
    chrI  unknown  stop_codon   535195  535197  .  +  .  gene_id  "psf-3";      gene_name  "psf-3";      p_id           "P6191";      transcript_id  "NM_058347";     tss_id  "TSS44728";
    chrI  unknown  CDS          535811  535852  .  +  0  gene_id  "icd-2";      gene_name  "icd-2";      p_id           "P19109";     transcript_id  "NM_182046";     tss_id  "TSS13551";
    chrI  unknown  CDS          535811  535852  .  +  0  gene_id  "icd-2";      gene_name  "icd-2";      p_id           "P20214";     transcript_id  "NM_001306345";  tss_id  "TSS13551";
  
    $ grep -w "psf-[1-9]" genes.gtf | column -t | (head -n2; tail -n2)
    chrI   unknown  CDS          534461    534572    .  +  0  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";   transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrI   unknown  exon         534461    534572    .  +  .  gene_id  "psf-3";  gene_name  "psf-3";  p_id  "P6191";   transcript_id  "NM_058347";  tss_id  "TSS44728";
    chrII  unknown  exon         9969452   9969517   .  +  .  gene_id  "psf-1";  gene_name  "psf-1";  p_id  "P21912";  transcript_id  "NM_063752";  tss_id  "TSS39626";
    chrII  unknown  stop_codon   9969515   9969517   .  +  .  gene_id  "psf-1";  gene_name  "psf-1";  p_id  "P21912";  transcript_id  "NM_063752";  tss_id  "TSS39626";
  
    $ grep -w -E "(psf-1|psf-2)" genes.gtf | column -t | head
    chrI   unknown  CDS          15053014  15053427  .  +  0  gene_id  "psf-2";  gene_name  "psf-2";  p_id  "P19112";  transcript_id  "NM_061226";  tss_id  "TSS10971";
    chrI   unknown  exon         15053014  15053427  .  +  .  gene_id  "psf-2";  gene_name  "psf-2";  p_id  "P19112";  transcript_id  "NM_061226";  tss_id  "TSS10971";
    chrI   unknown  start_codon  15053014  15053016  .  +  .  gene_id  "psf-2";  gene_name  "psf-2";  p_id  "P19112";  transcript_id  "NM_061226";  tss_id  "TSS10971";
    chrI   unknown  CDS          15053479  15053604  .  +  0  gene_id  "psf-2";  gene_name  "psf-2";  p_id  "P19112";  transcript_id  "NM_061226";  tss_id  "TSS10971";
    chrI   unknown  exon         15053479  15053607  .  +  .  gene_id  "psf-2";  gene_name  "psf-2";  p_id  "P19112";  transcript_id  "NM_061226";  tss_id  "TSS10971";
    chrI   unknown  stop_codon   15053605  15053607  .  +  .  gene_id  "psf-2";  gene_name  "psf-2";  p_id  "P19112";  transcript_id  "NM_061226";  tss_id  "TSS10971";
    chrII  unknown  CDS          9968622   9968720   .  +  0  gene_id  "psf-1";  gene_name  "psf-1";  p_id  "P21912";  transcript_id  "NM_063752";  tss_id  "TSS39626";
    chrII  unknown  exon         9968622   9968720   .  +  .  gene_id  "psf-1";  gene_name  "psf-1";  p_id  "P21912";  transcript_id  "NM_063752";  tss_id  "TSS39626";
    chrII  unknown  start_codon  9968622   9968624   .  +  .  gene_id  "psf-1";  gene_name  "psf-1";  p_id  "P21912";  transcript_id  "NM_063752";  tss_id  "TSS39626";
    chrII  unknown  CDS          9968767   9968831   .  +  0  gene_id  "psf-1";  gene_name  "psf-1";  p_id  "P21912";  transcript_id  "NM_063752";  tss_id  "TSS39626";

    $ grep -c -w "psf" genes.gtf
    30

#### `sort` and `uniq`

`sort`: sort lines of text files

`man sort`

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

    $ sort -k1,1 -k2,2n example.bed 
    chr1	9	28
    chr1	10	19
    chr1	26	39
    chr1	32	47
    chr1	40	49
    chr2	35	54
    chr3	11	28
    chr3	16	27
    
    $ sort -k1,1 -k2,2n -r example.bed 
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
  
    sort -R genes.gtf > genes_random.gtf
    
    sort -k1,1 -k4,4n -s genes_random.gtf > genes_sorted.gtf
    
    $ sort -k1,1 -k4,4n -c genes_sorted.gtf
    $ echo $?
    0
    
    $ sort -k1,1 -k4,4n -c genes.gtf
    sort: genes.gtf:23: disorder: chrI	unknown	CDS	16473	16582	.	+	2	gene_id "nlp-40"; gene_name "nlp-40"; p_id "P17245"; transcript_id "NM_058259"; tss_id "TSS21354";
    $ echo $?
    1

    $ sort -k1,1 -k4,4n -s -c genes.gtf
    $ echo $?
    0

---

`uniq`: report or omit repeated lines

`man uniq`

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
    
    $ cut -f3 genes.gtf | sort | uniq -c
    180946 CDS
    207586 exon
     27721 start_codon
     27721 stop_codon

    $ cut -f3 genes.gtf | sort | uniq -c | sort -rn
    207586 exon
    180946 CDS
     27721 stop_codon
     27721 start_codon

    $ cut -f3,7 genes.gtf | sort | uniq -c | sort -rn | column -t
    105558  exon         +
    102028  exon         -
    92152   CDS          +
    88794   CDS          -
    14092   stop_codon   +
    14092   start_codon  +
    13629   stop_codon   -
    13629   start_codon  -

    $ grep -w "psf-3" genes.gtf | cut -f3 | sort | uniq -c
    4 CDS
    4 exon
    1 start_codon
    1 stop_codon

#### `awk`

`awk`: pattern scanning and processing language

`man awk`

    $ awk '{print $0}' example.bed 
    chr1	26	39
    chr1	32	47
    chr3	11	28
    chr1	40	49
    chr3	16	27
    chr1	9	28
    chr2	35	54
    chr1	10	19

    $ awk '{print $2 "\t" $3}' example.bed 
    26	39
    32	47
    11	28
    40	49
    16	27
    9	28
    35	54
    10	19

    $ awk '$3 - $2 > 18' example.bed 
    chr1	9	28
    chr2	35	54
    
    $ awk '$1 ~ /chr1/ && $3 - $2 > 10' example.bed 
    chr1	26	39
    chr1	32	47
    chr1	9	28
 
    $ awk '$1 !~ /chr1/ && $3 - $2 > 10' example.bed 
    chr3	11	28
    chr3	16	27
    chr2	35	54

<pre>
<b>$ awk '$1 ~/chr2|chr3/ {print $0 "\t" $3 -$2}' example.bed</b>
chr3	11	28	17
chr3	16	27	11
chr2	35	54	19
</pre>
<pre>
<b>$ awk 'BEGIN{ s=0 }; { s += ($3-$2) }; END{ print "mean: " s/NR };' example.bed</b>
mean: 14
</pre>
<pre>
# convert CSV to tab-delimited
<b>$ awk -F"," -vOFS="\t" { print $1,$2,$3} my.csv</b>
</pre>
<pre>
# using <i>associative arrays</i> to count the number of features for the gene <i>psf-1</i>
<b>$ awk '/"psf-1"/ {feature[$3] +=1 }; END {for (k in feature) print k "\t" feature[k] }' genes.gtf</b>
exon	6
CDS	6
start_codon	1
stop_codon	1
</pre>

---

##### Exercise 

Use `grep`, `cut`, `sort` and `uniq` to count the number of features for the gene *psf-1*

    $ grep -w "psf-1" genes.gtf | cut -f3 | sort | uniq -c
    
---
    
#### `bioawk`

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
	
<pre>
# get the number of entries in a fastq file
bioawk -c fastx 'END {print NR}' contam.fastq
</pre>
<pre>
# convert from fastq to fasta
<b>$ bioawk -c fastx '{print ">"$name"\n"$seq}' contam.fastq | head -n4</b>
>DJB775P1:248:D0MDGACXX:7:1202:12362:49613
TGCTTACTCTGCGTTGATACCACTGCTTAGATCGGAAGAGCACACGTCTGAA
>DJB775P1:248:D0MDGACXX:7:1202:12782:49716
CTCTGCGTTGATACCACTGCTTACTCTGCGTTGATACCACTGCTTAGATCGG
</pre>
<pre>
# convert from fastq to fasta and reverse complement the sequence 
<b>$ bioawk -c fastx '{print ">"$name"\n"revcomp($seq)}' contam.fastq | head -n4</b>
>DJB775P1:248:D0MDGACXX:7:1202:12362:49613
TTCAGACGTGTGCTCTTCCGATCTAAGCAGTGGTATCAACGCAGAGTAAGCA
>DJB775P1:248:D0MDGACXX:7:1202:12782:49716
CCGATCTAAGCAGTGGTATCAACGCAGAGTAAGCAGTGGTATCAACGCAGAG
</pre>
<pre>
# get the genome lengths
<b>$ bioawk -c fastx '{print $name,length($seq)}' genome.fa</b>
chrI	15072423
chrII	15279345
chrIII	13783700
chrIV	17493793
chrM	13794
chrV	20924149
chrX	17718866
</pre>

#### `sed`

stream editor for filtering and transforming text

`man sed`

<pre>
<b>$ cat genes.gtf | head -n4</b>
chrI	unknown	exon	3747	3909	.	-	.	gene_id "Y74C9A.6"; gene_name "Y74C9A.6"; transcript_id "NR_001477"; tss_id "TSS32524";
chrI	unknown	exon	4221	4358	.	-	.	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";
chrI	unknown	stop_codon	4221	4223	.	-	.	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";
chrI	unknown	CDS	4224	4358	.	-	0	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";

# using sed for stream substitution
<b>$ sed 's/chr/chromosome/' genes.gtf | head -n4</b>
chromosomeI	unknown	exon	3747	3909	.	-	.	gene_id "Y74C9A.6"; gene_name "Y74C9A.6"; transcript_id "NR_001477"; tss_id "TSS32524";
chromosomeI	unknown	exon	4221	4358	.	-	.	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";
chromosomeI	unknown	stop_codon	4221	4223	.	-	.	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";
chromosomeI	unknown	CDS	4224	4358	.	-	0	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";

# regex groups
<b>$ echo "chrI:3747-3909" | sed -E 's/^(chr[^:]+):([0-9]+)-([0-9]+)/\1\t\2\t\3/'</b>
chrI	3747	3909

# ranges of lines
<b>$ sed -n '1,4p' genes.gtf</b>
chrI	unknown	exon	3747	3909	.	-	.	gene_id "Y74C9A.6"; gene_name "Y74C9A.6"; transcript_id "NR_001477"; tss_id "TSS32524";
chrI	unknown	exon	4221	4358	.	-	.	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";
chrI	unknown	stop_codon	4221	4223	.	-	.	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";
chrI	unknown	CDS	4224	4358	.	-	0	gene_id "homt-1"; gene_name "homt-1"; p_id "P20583"; transcript_id "NM_058260"; tss_id "TSS17015";

# ranges of lines
<b>$ sed -n '20,24p' genes.gtf</b>
chrI	unknown	exon	15103	15160	.	+	.	gene_id "nlp-40"; gene_name "nlp-40"; p_id "P17276"; transcript_id "NM_001306277"; tss_id "TSS24274";
chrI	unknown	start_codon	15103	15105	.	+	.	gene_id "nlp-40"; gene_name "nlp-40"; p_id "P17276"; transcript_id "NM_001306277"; tss_id "TSS24274";
chrI	unknown	CDS	16473	16582	.	+	2	gene_id "nlp-40"; gene_name "nlp-40"; p_id "P17276"; transcript_id "NM_001306277"; tss_id "TSS24274";
chrI	unknown	CDS	16473	16582	.	+	2	gene_id "nlp-40"; gene_name "nlp-40"; p_id "P17245"; transcript_id "NM_058259"; tss_id "TSS21354";
chrI	unknown	exon	16473	16585	.	+	.	gene_id "nlp-40"; gene_name "nlp-40"; p_id "P17276"; transcript_id "NM_001306277"; tss_id "TSS24274";

</pre>
Like `grep`, `sed` uses per default *POSIX Basic regular Expressions (BRE)*.
Like `grep`, you can use `-E` to switch to *POSIX Extended regular Expressions (ERE)*

Per default, `sed` replaces only the **first occurrence** of a match. To replace all occurrences, use the *global* flag:
`sed s/pattern/replacement/g`

---
##### Exercise 
1. Simplify above unsing `sed`
2. Simplify above using `tr`

<pre>
$ echo "chrI:3747-3909" | sed 's/[:-]/\t/g'
chrI	3747	3909

$ echo "chrI:3747-3909" | sed 's/:/\t/' | sed 's/-/\t/'
chrI	3747	3909

$ echo "chrI:3747-3909" | sed -e 's/:/\t/' -e 's/-/\t/'
chrI	3747	3909

$ echo "chrI:3747-3909" | tr ':-' '\t'
chrI	3747	3909
</pre>

---

### Indexing Fasta Files

---

### Alignment Data

## Exercises



## Extras

### Monitoring

`top`

`iotop`

`ps`

### Subshells

*sequential* commands (connected with `&&`) and *piped* commands (connected with `|`)
Sequential:
1. *not* connected, both print to stdout.
2. `&&` consideres exit status, `;` doesn't.

<pre>
<b>$ echo "this command"; echo "that command" | sed 's/command/step/'</b>
this command
that step

<b>$ (echo "this command"; echo "that command") | sed 's/command/step/'</b>
this step
that step
</pre>

## Further Reading

1. 

2. 
