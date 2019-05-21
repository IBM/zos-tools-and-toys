# wjsfsmon

File system monitor

PROPERTY OF IBM
COPYRIGHT IBM CORP. 2009,2010

Author: Bill Schoen <wjs@us.ibm.com>

# Purpose
This utility will monitor file system usage for the purpose of
helping you decide which file systems might perform better if
they are changed to make use of the zFS sysplex capability.

You must be a superuser to start or end the monitor.
You should have a 7 color 3270 to view the data.

# Syntax
`wjsfsmon <option>`

Options (valid combinations shown):

`-s <-i interval> <-h history>`

Start monitor on this system using <interval> seconds and keep <history> number                 of intervals. Default: `-s -i 60 -h 60`

`-sa <-i interval> <-h history>`

Start monitor on all systems using `<interval>` seconds and keep `<history>` number
of intervals. 
Default: `-s -i 60 -h 60`

This is only supported when run using sysrexx
`f axr,wjsfsmon,t=0 -sa`

`-e`

End monitor on all systems and clear data.

`-w file`

Snapshot the current history and copy to file.
For `file` specify a full dataset name.

`-q`

query monitor status on all systems

`-r file`
read and process history data.  Use `-r active` to process active data in the sysplex
