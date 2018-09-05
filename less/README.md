# less

`less` is a text pager, similar to `more`.  It's a drop-in replacement, and is the default pager on a number of operating systems.  

Contained here are a precompiled binary version (less-xxx.bin.tar.gz) and the source code (less-xxx.tar.gz)
To use the binary version, issue the following command:

```
gunzip -c less-xxx.bin.tar.gz | tar -xvf -
```

If you want to compile the source code yourself, issue the following commands:

```
CFLAGS="-Wc,xplink,inline,'target(zosv2r1)' -O2" LDFLAGS="-Wl,xplink,edit=no" ./configure
make
```

