Title: The Cloud and the Shell - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: training at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg

# Applied Bioinformatics in the Cloud and in the Shell

## RNA-Seq Analysis Using Unix and Open Source Tools 

[TOC]

### Preparations

0. Install [VirtualBox](https://www.virtualbox.org/).

0. Download Ubuntu Linux Virtual Machine
  
  `ftp://public:public@silico-sciences.com:/vm.zip`.

  Unzip and copy the `VM` folder to
  
  `C:\Users\[username]\Virtualbox VMs` (Windows) or to
  
  `~/VirtualBox VMs` (Ubuntu).
    
0. Start the virtual machine and open a terminal.

0. Verify TopHat is installed.

        $ tophat -v
        TopHat v2.1.0

0. Verify Samtools is installed.

        $ samtools
        Program: samtools (Tools for alignments in the SAM format)
        Version: 0.1.19-96b5f2294a


0. Verify Cufflinks is installed.

        $ cufflinks
        cufflinks v2.2.1
        linked against Boost version 104700

0. Verify RStudio is installed.

    0. Verify cummeRbund is installed.
    
[Back to Index](../README.md)


