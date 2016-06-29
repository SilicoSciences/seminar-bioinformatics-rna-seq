Title: The Cloud and the Shell - Applied Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: training at silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg

# Applied Bioinformatics in the Cloud and in the Shell

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
