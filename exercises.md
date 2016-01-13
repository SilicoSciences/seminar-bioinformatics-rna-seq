Title: The Shell and the Cloud - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: ak at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg 2016-01-20 - 2016-01-22

# Applied Bioinformatics in the Shell and in the Cloud

## NGS Data Analysis Using Unix and Open Source Tools

# Exercises

## Working with Bioinformatics Data

### Simplify the following using `sed` and `tr`

    $ echo "chrI:3747-3909" | sed -E 's/^(chr[^:]+):([0-9]+)-([0-9]+)/\1\t\2\t\3/'

    $ echo "chrI:3747-3909" | sed 's/[:-]/\t/g'
    chrI	3747	3909

    $ echo "chrI:3747-3909" | sed 's/:/\t/' | sed 's/-/\t/'
    chrI	3747	3909

    $ echo "chrI:3747-3909" | sed -e 's/:/\t/' -e 's/-/\t/'
    chrI	3747	3909

    $ echo "chrI:3747-3909" | tr ':-' '\t'
    chrI	3747	3909