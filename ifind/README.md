#/* Copyright 1994, IBM Corporation
# * All rights reserved
# *
# * Distribute freely, except: don't remove my name from the source or
# * documentation (don't take credit for my work), mark your changes
# * (don't get me blamed for your possible bugs), don't alter or
# * remove this notice.  No fee may be charged if you distribute the
# * package (except for such things as the price of a disk or tape,
# * postage, etc.).  No warranty of any kind, express or implied, is
# * included with this software; use at your own risk, responsibility
# * for damages (if any) to anyone resulting from the use of this
# * software rests entirely with the user.
# *
# * Send me bug reports, bug fixes, enhancements, requests, flames,
# * etc.  I can be reached as follows:
# *
# *          John Pfuntner      John_Pfuntner@tivoli.com
# */

DESCRIPTION

  ifind is a tool that can be used to find files in a filesystem that
  share the same data.  A file can be known by several different links
  (sometimes called a "hard link" to distinguish them from "symbolic
  links) and they all point to the same "inode" - a number which
  uniquely identifies the file in the filesystem.

  You can search for files by specifying the name of one of the links
  to the file or by specifying the inode as a decimal number.  If you
  specify the inode, ifind assumes you mean you want to search the
  filesystem containing the current working directory.  Since ifind
  assumes a decimal number is an inode, if you want to search for a
  file by its name which is composed of only digits (such as "1"), you
  must specify it in a way that it is unambiguous ("./1" for
  instance).

  Here's an example:

    $ ifind /bin/kill
    searching for links of /bin/kill (inode 406) in /
    /bin/cd
    /bin/command
    /bin/getopts
    /bin/read
    /bin/wait
    /bin/IBM/FSUMSSHB

INSTALLATION

  No makefile is provided for this program but you can still use make
  to compile it.  It only has one source file so if you say "make
  ifind", make's built-in rules have enough information to know that
  it needs to compile and link the program.
