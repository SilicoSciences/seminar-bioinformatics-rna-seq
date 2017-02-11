#!/bin/bash
set -e

tophatOut=tophat_out*

function f_doIt {
echo "dollarOne: ${1}"
for f in ${1}/$tophatOut/accepted_hits.bam
do
echo "f: ${f}"
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Cleaning $1/$tophatOut/"
echo "-------------------------------------------"
if [[ -f $f ]]; then
echo "hieroglyph: ${f%/*}"
rm -rf "${f%/*}"/tmp
rm -rf "${f%/*}"/logs
rm -f "${f%/*}"/*_sorted.bam
rm -f "${f%/*}"/*.bai
fi
done
}

while [ "$1" != "" ]; do
  f_doIt $1 && shift;
done;



