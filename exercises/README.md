Title: The Cloud and the Shell - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: training at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg

# Applied Bioinformatics in the Cloud and in the Shell

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