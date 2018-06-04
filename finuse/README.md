# finuse

List users of a file

Author: Bill Schoen  wjs at ibmusm10, wjs@us.ibm.com

Title: List users of a file -- REQUIRES AT LEAST OS390R2

Property of IBM
Copyright IBM Corp. 1999


## Syntax

    finuse <pathname>

This lists the process id, user id, and uid of any users that are currently using the file or directory <pathname>.  This utility requires superuser authority.

## Example

    finuse /u/wjs/.profile

This will list all processes that are using the file /u/wjs/.profile

## Install Information

Place finuse in a directory where you keep executable programs.  Make sure the permission bits are set to 0555 (or at least 0500) so that a superuser can execute it.  If you would like it to be useable by anyone, set the permissions to 04555 to make it a setuid program.  The file owner must be uid 0.  If you obtain this program via FTP, the program is a REXX program in source form.  Transfer it in text mode.  As a reminder, the filename is **finuse.rexx**.
