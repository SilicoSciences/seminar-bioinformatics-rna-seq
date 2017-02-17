#!/bin/bash
set -e

function f_cuffnorm {
cuffnorm -o $cuffnormOut -L $labels -p $processes $annotations $files0 $files1 $files2
echo "Cuffnorm exit code $?"
}

function f_doIt {
f_cuffnorm
}
