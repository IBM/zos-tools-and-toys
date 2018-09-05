# less

`less` is a text pager, similar to `more`.  It's a drop-in replacement, and is the default pager on a number of operating systems.  

If you are looking for the precompiled binary version for z/OS, download it here:
[less-530](https://github.com/IBM/zos-tools-and-toys/files/2353283/less-530.bin.tar.gz)

If you want to compile the source code yourself, issue the following commands:

```
CFLAGS="-Wc,xplink,inline,'target(zosv2r1)' -O2" LDFLAGS="-Wl,xplink,edit=no" ./configure
make
```

