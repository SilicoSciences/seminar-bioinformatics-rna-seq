#!/bin/bash
set -e

function f_cuffdiff {
cuffdiff -o $cuffdiffOut -L $labels -p $processes -b $reference -u $annotations $files0 $files1 $files2
echo "Cuffdiff exit code $?"
}

function f_doIt {
f_cuffdiff
}
