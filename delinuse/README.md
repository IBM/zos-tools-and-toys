Author: Bill Schoen  <wjs@us.ibm.com>
 
Title: delinuse
 
PROPERTY OF IBM
COPYRIGHT IBM CORP. 2006
     
Purpose
=======

It is fairly common practice for a program to open a temporary file,
delete the file, and continue to use it as a temporary file.  By doing
so, other programs will not be able to open and read or corrupt the
data this program is using.  However, since no name appears in a
directory, it becomes difficult to determine space being used by these
types of files.  For example, a file system can become full yet looking
at the files that appear to be in the file system, it may appear that
the file system should have considerable space available.
 
This tool will find files in a file system that have been deleted yet
are still in use and consuming space.  It will show the process and
user using the file, the space in use, and a portion of the name used
to open the file.
 
     
Syntax:
=======
 
delinuse <pathname>
 
Usage:
======

This must be run by a superuser.  This program can run from a TSO or
shell environment.
 
 
Install information:
===================
 
Download delinuse.txt in text format.
 
Copy this in text format to a PDS where REXX execs can be run     .
and/or to a pathname where programs can be run.  If copied to a path
be sure to set permissions so the file can be read and executed.

