# wjsfsmon

File system monitor

PROPERTY OF IBM
COPYRIGHT IBM CORP. 2009,2010

Bill Schoen    <wjs@us.ibm.com>

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
     start monitor on this system using <interval> seconds and keep <history> number
                  of intervals. Default: `-s -i 60 -h 60`
     `-sa <-i interval> <-h history>`
     start monitor on all systems using `<interval>` seconds and keep `<history>` number
                  of intervals. Default: `-s -i 60 -h 60`
                  This is only supported when run using sysrexx
                     `f axr,wjsfsmon,t=0 -sa`
     `-e`          end monitor on all systems and clear data
     `-w file`     snapshot the current history and copy to file
                  for file specify a full data set name
     `-q`          query monitor status on all systems
     `-r file`     read and process history data
                 use -r active to process active data in the sysplex
