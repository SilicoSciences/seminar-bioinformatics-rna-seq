#!/bin/bash
set -e

source global-cuffdiff.sh

desc="Cuffdiff lung,stomach,heart big"

cuffdiffOut=cuffdiff-lung-stomach-heart_out
cuffquantOut=cuffquant_out
labels=lung,stomach,heart
files0=ERR315326/$cuffquantOut/abundances.cxb,ERR315424/$cuffquantOut/abundances.cxb,ERR315353/$cuffquantOut/abundances.cxb,ERR315487/$cuffquantOut/abundances.cxb
files1=ERR315369/$cuffquantOut/abundances.cxb,ERR315485/$cuffquantOut/abundances.cxb,ERR315467/$cuffquantOut/abundances.cxb,ERR315379/$cuffquantOut/abundances.cxb
files2=ERR315384/$cuffquantOut/abundances.cxb,ERR315413/$cuffquantOut/abundances.cxb,ERR315331/$cuffquantOut/abundances.cxb,ERR315367/$cuffquantOut/abundances.cxb
processes=7
annotations=/var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf
reference=/var/data/bi/reference/prebuild/Homo_sapiens/Ensembl/GRCh37/Sequence/WholeGenomeFasta/genome.fa

f_doIt
