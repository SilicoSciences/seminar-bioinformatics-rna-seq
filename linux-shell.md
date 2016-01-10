Title: From the Shell and the Cloud - Common Bioinformatics on the Example of Gene Expression Analysis using Unix and freely available Open Source Tools</br>
Author: Alexander Kerner</br>
EMail: ak@silico-sciences.com</br>
Seminar Ruprecht-Karls-Universität Heidelberg 2016-01-20 - 2016-01-22

# Bioinformatics Data in the Unix Shell and -Cloud

### Common Bioinformatics Using Unix and Freely Available Open Source Tools on the Example of Gene Expression Analysis

# Linux for Bioinformatics

## Why Unix?

> This isthe Unix philosophy: Write programs that do one thing and do it well. Write programs to work together. Write programs to handle text streams, because that is a universal interface.
[Doug McIlroy](https://en.wikipedia.org/wiki/Doug_McIlroy)

## Unix and the Shell

Speak to the Shell using commands it knows.
E.g., type `cal`

    $ cal
        January 2016      
    Su Mo Tu We Th Fr Sa  
                    1  2  
     3  4  5  6  7  8  9  
    10 11 12 13 14 15 16  
    17 18 19 20 21 22 23  
    24 25 26 27 28 29 30  
    31      

.. or `sl`              

Exit the Shell using the `exit` command

### Who am I?

`whoami`: print effective userid

### Where am I?

`hostname`: show or set the system's host name

---

`pwd`: print name of current/working directory

---

`ls`: list directory contents

    $ ls
    
    $ ls /
    bin    dev   initrd.img      lib32       media  proc  sbin  tmp  vmlinuz
    boot   etc   initrd.img.old  lib64       mnt    root  srv   usr  vmlinuz.old
    cdrom  home  lib             lost+found  opt    run   sys   var
    
    $ ls -l /
    total 152
    drwxr-xr-x   2 root root  4096 Dec 30 09:45 bin
    drwxr-xr-x   3 root root  4096 Dec 30 09:46 boot
    drwxr-xr-x   2 root root  4096 Jan 28  2015 cdrom
    drwxr-xr-x  19 root root  4420 Jan 10 10:01 dev
    drwxr-xr-x 166 root root 12288 Jan 10 17:22 etc
    drwxr-xr-x   5 root root  4096 Nov 30 10:29 home
    lrwxrwxrwx   1 root root    33 Aug 12 01:05 initrd.img -> boot/initrd.img-3.16.0-38-generic
    lrwxrwxrwx   1 root root    33 Jan 28  2015 initrd.img.old -> boot/initrd.img-3.13.0-37-generic
    drwxr-xr-x  25 root root  4096 Jun 22  2015 lib
    drwxr-xr-x   2 root root  4096 Dec 30 19:44 lib32
    drwxr-xr-x   2 root root  4096 Jun 22  2015 lib64
    drwx------   2 root root 16384 Jan 28  2015 lost+found
    drwxr-xr-x   3 root root  4096 Jan 28  2015 media
    drwxr-xr-x   4 root root  4096 May 13  2015 mnt
    drwxr-xr-x   7 root root  4096 Jan  4 12:43 opt
    dr-xr-xr-x 238 root root     0 Jan 10 10:01 proc
    drwx------  18 root root  4096 Nov 25 12:01 root
    drwxr-xr-x  30 root root  1060 Jan 10 10:06 run
    drwxr-xr-x   2 root root 12288 Dec 30 09:44 sbin
    drwxr-xr-x   2 root root  4096 Nov 26  2014 srv
    dr-xr-xr-x  13 root root     0 Jan 10 18:09 sys
    drwxrwxrwt   9 root root 53248 Jan 10 18:09 tmp
    drwxr-xr-x  11 root root  4096 Dec 30 19:44 usr
    drwxr-xr-x  12 root root  4096 Aug  3 22:40 var
    lrwxrwxrwx   1 root root    30 Aug 12 01:05 vmlinuz -> boot/vmlinuz-3.16.0-38-generic
    lrwxrwxrwx   1 root root    30 Jan 28  2015 vmlinuz.old -> boot/vmlinuz-3.13.0-37-generic

`ls -a` will display hidden files as well. In the Unix environment, a hidden file is defined by it's leading `.` in the filename:

	$ ls -a
    .   .bash_history  .cache   .lesshst  .profile
    ..  .bash_logout   .config  .mozilla

`.` and `..` represent to the current directory and to the parent directory, respectively.

`man ls`

Options to remember:

1. `-a`
1. `-h`
1. `-l`
1. `-t`
1. `-S`
1. `-F`

---

`tree`: list contents of directories in a tree-like format

    $ tree
    .

    0 directories, 0 files

`tree` understands the `-a` option as well:

<pre>
$ tree -a
.
|-- .bash_history
|-- .bash_logout
|-- .cache
|   `-- dconf
|       `-- user
|-- .config
|   |-- caja
|   |   `-- desktop-metadata
|   |-- chromium
|   |   |-- chrome_shutdown_ms.txt
|   |   |-- Default
</pre>

### Moving Around

`cd`: change directory

    $ cd .config/
    
    $ pwd
    /home/bi/.config
    
    $ cd .
    
    $ pwd
    /home/bi/.config
    
    $ cd ..
     
    $ pwd
    /home/bi
     
    $ cd /

    $ pwd
    /

    $ cd home
    
    $ pwd
    /home
    
    $ cd /home/bi

    $ pwd
    /home/bi
    
#### Shortcuts
    
`~` equals `/home/[my-username]`

`cd` equals `cd ~`

`cd -` `cd` to your last directory

`cd --` `cd` to your second last directory

     
### What is a Command Exactely?

    $ commandname -shortOption --longOption argument

Multiple options and arguments are possible.

Short options can be combined:

    $ ls -lath
    total 52K
    drwxr-xr-x 5 bi   bi   4,0K Jan 10 17:22 .
    -rw------- 1 bi   bi    17K Jan 10 17:22 .bash_history
    -rw------- 1 bi   bi     40 Dec 12 00:32 .lesshst
    drwx------ 3 bi   bi   4,0K Nov 30 10:33 .cache
    -rw-r--r-- 1 bi   bi    220 Nov 30 10:29 .bash_logout
    drwxr-xr-x 3 bi   bi   4,0K Nov 30 10:29 .mozilla
    drwxr-xr-x 5 bi   bi   4,0K Nov 30 10:29 .config
    -rw-r--r-- 1 bi   bi    675 Nov 30 10:29 .profile
    drwxr-xr-x 5 root root 4,0K Nov 30 10:29 ..


---

A command is either build-in the Shell, or 'installed' into some directory.

    $ type pwd
    pwd is a shell builtin
    
    $ type man
    man is hashed (/usr/bin/man)

    $ type tree
    tree is hashed (/usr/bin/tree)
    
    $ type ls
    ls is aliased to `ls --color=auto'
    
### The Unix File System

    $ cd /
    $ tree -d -L 1
    .
    |-- bin
    |-- boot
    |-- cdrom
    |-- dev
    |-- etc
    |-- home
    |-- lib
    |-- lib32
    |-- lib64
    |-- lost+found
    |-- media
    |-- mnt
    |-- opt
    |-- proc
    |-- root
    |-- run
    |-- sbin
    |-- srv
    |-- sys
    |-- tmp
    |-- usr
    `-- var

    22 directories
    
### Baisc Actions on Files and Foders

`touch`: change file timestamps

    $ touch myfile
    $ ls
        
---

`rm`: remove files or directories

    $ rm myfile
    $ ls
    
---

`mkdir`: make directories

    $ mkdir mydir
    $ cd mydir
    $ touch anotherfile
    $ ls
        
---

`rmdir`: remove empty directories

    $ ls mydir
    $ rm mydir/anotherfile
    $ ls mydir
    $ touch mydir/myfile
    $ rm -r mydir
    $ ls
    
---

`cp`: copy files and directories

    $ mkdir mydir
    $ touch mydir/myfile
    $ cp mydir/myfile myfile2
    $ ls
    $ cp -r mydir anotherdir
    $ ls -r
    
    $ $ ls -R
    .:
    anotherdir  mydir  myfile2
  
    ./anotherdir:
    myfile
  
    ./mydir:
    myfile

Options to remember:

1. `-i`
1. `-p`
1. `-a`
1. `-u`

---

`mv`: move (rename) files

    $ mv myfile2 myfile
    $ ls
    
    $ mv -i mydir/myfile anotherdir/
    mv: overwrite ‘anotherdir/myfile’? y
    
    $ ls -R
    .:
    anotherdir  mydir  myfile

    ./anotherdir:
    myfile

    ./mydir:
    
    $ touch mydir/myfile
    $ mv --backup=numbered mydir/myfile anotherdir/
    $ ls -R
    .:
    anotherdir  mydir  myfile

    ./anotherdir:
    myfile  myfile.~1~

    ./mydir:


Options to remember:

1. `-i`
1. `--backup=numbered`

### Interacting with the Terminal

`tab` auto-complete

`[up-arrow]` access your history

Open a terminal and type/ copy-pase a sentence:

    We can know only that we know nothing
    
Try the following key combinations on that text:
    
`[ctrl-arrow left]` `[ctrl-arrow right]`

`[home-key]` `[end-key]`

`[ctrl-a] [ctrl-e] [ctrl-f] [ctrl-b] [ctrl-d] [ctrl-l]`	

### Getting Help

`man`:  an interface to the on-line reference manuals

`man ls`

Search man pages by keyword

    $ man -k search
    apropos (1)          - search the manual page names and descriptions
    badblocks (8)        - search a device for bad blocks
    bsearch (3)          - binary search of a sorted array
    bzegrep (1)          - search possibly bzip2 compressed files for a regular expression
    bzfgrep (1)          - search possibly bzip2 compressed files for a regular expression
    bzgrep (1)           - search possibly bzip2 compressed files for a regular expression
    find (1)             - search for files in a directory hierarchy
    
`man` sections:

  1. User Commands
  1. System Calls
  1. C Library Functions
  1. Devices and Special Files
  1. File Formats and Conventions
  1. Games et. Al.
  1. Miscellanea
  1. System Administration tools and Deamons
  
Example:
  
    $ man printf
    $ man 1 printf
    $ man 3 printf
    $ man -a printf
    --Man-- next: printf(3) [ view (return) | skip (Ctrl-D) | quit (Ctrl-C) ]
    $ man -k "^printf"
    printf (1)           - format and print data
    printf (3)           - formatted output conversion

---

`apropos`: search the manual page names and descriptions 

    $ apropos date
    updatedb.conf (5)    - a configuration file for updatedb(8)
    asctime (3)          - transform date and time to broken-down time or ASCII
    asctime_r (3)        - transform date and time to broken-down time or ASCII
    autoreconf (1)       - Update generated configuration files
    autoupdate (1)       - Update a configure.in to a newer Autoconf
    cal (1)              - displays a calendar and the date of Easter
    
---

`whatis`: display one-line manual page descriptions

    $ whatis ls
    ls (1)               - list directory contents
    LS (6)               - display animations aimed to correct users who accidentally enter LS instead of ls .

---

`help -m cd`

---

`which`: locate a command

    $ which ls
    /bin/ls
    
    $ which cd
    
## References

1. [http://code.snipcademy.com/](http://code.snipcademy.com/tutorials/linux-command-line/basic-commands/introduction)
