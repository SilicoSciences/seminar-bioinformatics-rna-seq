#!/bin/bash
set -e

function f_cuffquant {
echo "cuffquant"
cuffquant -o "ERR315${i}/$cuffquantOut" -q -p$processes -b $bowtie2Index -u $annotations "ERR315${i}/$tophatOut/accepted_hits.bam"
exitCode=$?
echo "cuffquant exit code $exitCode"
return $exitCode
}

function f_doIt {
if [ -f "ERR315${i}/cuffquant_out/abundances.cxb" ]
    then
    echo "Files exist, skipping Cuffquant"
else
f_cuffquant
fi
}
