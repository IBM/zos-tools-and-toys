# fduse

Show file descriptor usage.

Author: Bill Schoen <wjs@us.ibm.com>

Property of IBM

Copyright IBM Corp. 1999

## Syntax

    fduse <pid> ...

This lists for all processes or the specified processes the number of file descriptors that are in use.  This utility requires superuser authority.

## Example

    fduse

This will list all processes and the number of descriptors each has in use.

## Install Information

Place fduse in a directory where you keep executable programs.  Make sure the permission bits are set to 0555 (or at least 0500)  so that a superuser can execute it.  If you would like it to be useable by anyone, set the permissions to 04555 to make it a setuid program.  The file owner must be uid 0.  This program can also be placed in a PDS where REXX execs can be run and used like other REXX execs in a TSO environment.  If you obtain this program via FTP, the program is a REXX program in source form.  Transfer it in text mode.  As a reminder, the filename is **fduse.rexx**.
