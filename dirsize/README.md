# dirsize

Copyright 1994, 2000, IBM Corporation and Tivoli Systems

All rights reserved

Author: John Pfuntner <John_Pfuntner@tivoli.com>

## Description

  See dirsize.1 (the man page) for a description of the command.

## Installation

No makefile is provided for this program but you can still use make to compile it.  It only has one source file so if you say "make dirsize", make's built-in rules have enough information to know that it needs to compile and link the program.  It would be nice to make the man page available to users too.  You might consider doing:  

    mkdir -p /usr/doc/cat1
    cp dirsize.1 /usr/doc/cat1
  
and putting the following in /etc/profile or have individual users do it in their $HOME/.profile themselves:
  
    export MANPATH='/usr/man/%L:/usr/doc'
