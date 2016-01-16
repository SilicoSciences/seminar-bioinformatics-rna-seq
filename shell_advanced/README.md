Title: The Shell and the Cloud - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: teaching at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg 2016-01-20 - 2016-01-22

# Applied Bioinformatics in the Shell and in the Cloud

## NGS Data Analysis Using Unix and Open Source Tools 

# Advanced

## Monitoring

`top`

`iotop`

`ps`

## Subshells

*sequential* commands (connected with `&&`) and *piped* commands (connected with `|`)
Sequential:
1. *not* connected, both print to stdout.
2. `&&` consideres exit status, `;` doesn't.

    $ echo "this command"; echo "that command" | sed 's/command/step/'
    this command
    that step

    $ (echo "this command"; echo "that command") | sed 's/command/step/'
    this step
    that step
