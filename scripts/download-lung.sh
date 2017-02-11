#!/bin/bash
set -e

source global-download.sh

desc="Download lung dataset"

echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$desc"
echo "-------------------------------------------"
## for i in {353,487,439,444}
for i in {326,424,353,487,439,444}
## for i in {326,424}
do
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Now $i"
echo "-------------------------------------------"
f_doIt
done
echo "All done!"


