/* REXX */
/**********************************************************************/
/* List users of deleted files                                        */
/*                                                                    */
/* Purpose:  Find active users of deleted files consuming space       */
/*                                                                    */
/* Syntax:                                                            */
/*    delinuse <pathname>                                             */
/* Example:                                                           */
/*    delinuse /tmp/                                                  */
/*                                                                    */
/* PROPERTY OF IBM                                                    */
/* COPYRIGHT IBM CORP. 2006                                           */
/*                                                                    */
/* Bill Schoen (wjs@us.ibm.com)                                       */
/**********************************************************************/
numeric digits 12
pctcmd=-2147483647
pfs='KERNEL'
parse source . how . . . . . omvs .
if omvs<>"OMVS" then
   call syscalls 'ON'
address syscall
catd=-1

z1='00'x
z2='0000'x
z4='00000000'x
laddr=0
lalet=0
llen=0
cvtecvt=140
ecvtocvt=240
ocvtocve=8
ocvtfds='58'
ocvtkds='48'
ocveppra='8'
ppralast='c'
ppraltok='10'
ppraelement='30'
pprapprp=4
ppraelementlen=8
pprpfupt='58'
fuptcwd='8'
fuptcrd='c'
fuptffdt='10'
fuptsab='70'
ffdtinuse=4
ffdtofte=12
ffdtnext='8'
ffdtlen='414'
ffdtents=64
ffdtentlen=16
ffdthdrlen=20
sabvdecount='40'
sabvdehead='44'
vdevnodeptr='8'
vdeforwardchain='18'
vdefreestate='14'
vdefreestatef='80'x
oftevnode='8'
vnodvfs='18'
vnodfid='74'
vnodflags='38'
ofsb='1000'
ofsbgfs='08'
ofsblen='200'
vfsnext='08'
vfsflags='34'
vfsfilesysname='38'
vfsavailable='0080'x
vfslen='190'
gfsnext='08'
gfsvfs='0c'
gfspfs='10'
gfsname='18'
gfsflags='2c'
gfsdead='80'x
gfslen='80'

cvt=c2x(storage(10,4))
ecvt=c2x(storage(d2x(x2d(cvt)+cvtecvt),4))
ocvt=c2x(storage(d2x(x2d(ecvt)+ecvtocvt),4))
ocve=c2x(storage(d2x(x2d(ocvt)+ocvtocve),4))

fds=storage(d2x(x2d(ocvt)+x2d(ocvtfds)),4)
kds=storage(d2x(x2d(ocvt)+x2d(ocvtkds)),4)

if fetch(fds,'00001000'x,'10') then
   do
   call say 00,'Kernel is unavailable or at the wrong level',
                  'for this function or you are not a superuser'
   exit 1
   end
parse arg prm .
if prm='' then
   do
   call say 00,'Syntax:  delinuse pathname'
   exit 1
   end
'stat (prm) st.'
if retval=-1 then
   do
   say 'stat error: errno='errno 'reason='errnojr 'path:' prm
   exit 1
   end

'v_reg 1 me'
'v_rpn (prm) vf vn stf. st2.'     
if retval<>0 then
   signal out

'getmntent ment.' x2d(st.st_dev)
if retval=-1 then
   do
   say 'getmntent error: errno='errno 'reason='errnojr
   exit 1
   end
vfsnm=ment.mnte_fsname.1
inuse=0
ix=0
call loadgfs
call loadvfs
vfs=''
vfs1=vfsnm
do i=1 to gfs.0 while vfs=''
   do j=1 to vfs.i.0 while vfs=''
     if getofs(vfs.i.j,vfsfilesysname,44)=vfsnm then
        vfs=vfs.i.j.0
   end
end
if vfs='' then
   do
   vfs2=translate(vfsnm)
   vfsnm=vfs2
   do i=1 to gfs.0 while vfs=''
      do j=1 to vfs.i.0 while vfs=''
        if getofs(vfs.i.j,vfsfilesysname,44)=vfsnm then
           vfs=vfs.i.j.0
      end
   end
   end
if vfs='' then
   do
   call say 00,'Unable to locate filesystem' vfs1
   call say 00,'Unable to locate filesystem' vfs2
   return
   end
call say 00,'Searching for users of deleted files in ',vfsnm
call fetch z4,x2c(ocve),10
ppra=ofs(ocveppra,4)
call fetch z4,ppra,10
pprpnum=c2d(ofs(ppralast,4))
pprafirst=c2d(ppra)+x2d(ppraelement)
pprplen=pprpnum*ppraelementlen
ppraents=''
do while pprplen>0
   i=min(4000,pprplen)
   call fetch z4,d2c(pprafirst),d2x(i)
   pprafirst=pprafirst+i
   pprplen=pprplen-i
   ppraents=ppraents || buf
end
do i=1 to pprpnum
   pprp=substr(ppraents,(i-1)*ppraelementlen+pprapprp+1,4)
   if substr(pprp,1,1)='F' |,
      substr(pprp,1,1)='V' then
      iterate
   if fetch(z4,pprp,60,'PPRP') then
     iterate
   call fetch fds,ofs(pprpfupt,4),80
   ffdt=ofs(fuptffdt,4)
   sab=ofs(fuptsab,4)
   do while ffdt<>z4          
      call fetch fds,ffdt,ffdtlen
      ffdt=ofs(ffdtnext,4)
      fdtbuf=buf
      do j=1 to ffdtents
         if getofs(fdtbuf,d2x(ffdthdrlen+(j-1)*ffdtentlen+ffdtinuse),1),
               <>'I' then iterate
         ofte=getofs(fdtbuf,d2x(ffdthdrlen+(j-1)*ffdtentlen+ffdtofte),4)
         call fetch fds,ofte,70
         if vnodindev(ofs(oftevnode,4),ofs(30,64)) then leave
      end
   end
   iterate /* skip sabs - no ofte */
   if sab=z4 then iterate
   call fetch fds,sab,50
   vdecount=c2d(ofs(sabvdecount,4))
   vde=ofs(sabvdehead,4)
   do vdecount while vde<>z4
      call fetch fds,vde,20
      vde=ofs(vdeforwardchain,4)
      if bitand(ofs(vdefreestate,1),vdefreestatef)<>z1 then iterate
      if vnodindev(ofs(vdevnodeptr,4)) then leave
   end
end

if ix=0 then
   do
   call say 00,'no users found'
   return
   end

'getpsent ps.'
do j=1 to ps.0
   do i=1 to ix
      pid=c2d(substr(ppraents,(p.i-1)*8+1,4))
      if pid=ps.j.ps_pid then
         do
         pw.=''
         'getpwuid' ps.j.ps_ruid 'pw.'
         fid=x2c(vnfid.i)
         'v_get vf fid vntok'
         if retval<>0 then
            signal out
         'v_getattr vntok vnst.'
         if retval<>0 then
            signal out
         call say 00,'PID='right(ps.j.ps_pid,12),
             strip(pw.pw_name)'('ps.j.ps_ruid')' 'Fid='vnfid.i,
             'Size='vnst.st_size
         say '   'names.i
         end
   end
end
return

/**********************************************************************/
vnodindev:
   svbuf=buf
   parse arg vnod,name
   call fetch fds,vnod,80
   if vfs=ofs(vnodvfs,4) & , 
        bitand(ofs(vnodflags,4),'00000004'x)='00000004'x then
      do
      fid=c2x(ofs(vnodfid,8))     
      if fids.fid<>1 then
         do
         fids.fid=1
         ix=ix+1
         p.ix=i
         vn.ix=vnod
         vnfid.ix=fid
         names.ix=name
         end
      end
   buf=svbuf
   return 0    

/**********************************************************************/
ofs:
   arg ofsx,ln
   return substr(buf,x2d(ofsx)+1,ln)

/**********************************************************************/
getofs:
   parse arg zbuf,ofsx,ln
   return substr(zbuf,x2d(ofsx)+1,ln)

/**********************************************************************/
loadgfs:
   call fetch fds,x2c(right(ofsb,8,0)),ofsblen
   ofsb.1=buf
   gfsptr=ofs(ofsbgfs,4)
   gi=0
   do while gfsptr<>z4
      call fetch fds,gfsptr,gfslen
      gfsptr=ofs(gfsnext,4)
      if bitand(ofs(gfsflags,1),gfsdead)<>z1 then
         iterate
      gi=gi+1
      gfs.gi=buf
   end
   gfs.0=gi
   return

/**********************************************************************/
loadvfs:
   do i=1 to gfs.0
      j=0
      vfsptr=getofs(gfs.i,gfsvfs,4)
      do while vfsptr<>z4
         call fetch fds,vfsptr,vfslen
         vfslast=vfsptr
         vfsptr=ofs(vfsnext,4)
         if bitand(ofs(vfsflags,2),vfsavailable)<>z2 then
            iterate
         j=j+1
         vfs.i.j=buf
         vfs.i.j.0=vfslast
      end
      vfs.i.0=j
   end
   vfs.0=gfs.0
   return
/**********************************************************************/
fetch:
   parse arg alet,addr,len,eye  /* char: alet,addr  hex: len */
   len=x2c(right(len,8,0))
   dlen=c2d(len)
   buf=alet || addr || len
   'pfsctl' pfs pctcmd 'buf' max(dlen,12)
   if retval=-1 then
      return 1
   if rc<>0 then
      do
      say 'buf:' c2x(buf)
      say 'len:' max(dlen,12)
      signal halt
      end
   if eye<>'' then
      if substr(buf,1,length(eye))<>eye then
         return 1
   if dlen<12 then
      buf=substr(buf,1,dlen)
   return 0

out:
   say retval errno errnojr
   exit

/**********************************************************************/
/* All messages are issued by the say function.                       */
/* Parms:  1   message number                                         */
/*         2   message text                                           */
/*         3-n substitution text                                      */
/* Use %% as a place-holder for substitution text.                    */
/* The following global variables must be set                         */
/*    catd   catalog descriptor                                       */
/*    mset   message set number                                       */
/**********************************************************************/
say: procedure expose catd mset
   mtext=arg(2)
   if catd>=0 & arg(1)>0 then
      address syscall "catgets" catd mset arg(1) "mtext"
   do si=3 to arg()
      parse var mtext mtpref '%%' mtsuf
      mtext=mtpref || arg(si) || mtsuf
   end
   say mtext
   return
