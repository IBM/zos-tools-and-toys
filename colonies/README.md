Author: Bill Schoen  WSCHOEN at KGNVMC, schoen@vnet.ibm.com

Title: List colony address space names -- REQUIRES AT LEAST OS390R2

PROPERTY OF IBM
COPYRIGHT IBM CORP. 1998

colonies
========

  Syntax:  colonies

  This lists the name of any colony address spaces.
  This utility can be useful to determine the names of colony
  address spaces if you need to terminate them.


  Install Information
  ===================

  Place colonies in a directory where you keep executable programs.
  Make sure the permission bits are set to 0555 (or at least 0500)
  so that a superuser can execute it.  If you would like it to be
  useable by anyone, set the permissions to 04555 to make it a
  setuid program.  The file owner must be uid 0.

  If you obtain this program via FTP, the program is a REXX program
  in source form.  Transfer it in text mode.  As a reminder, the
  filename is colonies.txt.
.
