 source /usr/skel/syswide.cshrc
 source /ecelib/linware/profile/mentor15
 source /ecelib/linware/profile/cadence616

setenv PATH ".:/ecelib/linware/cadence/INCISIV/tools.lnx86/bin:/usr/lib/":$PATH
setenv LM_LICENSE_FILE 5280@zuma.eecs.uci.edu:27000@vivian.eecs.uci.edu
setenv CDS_LIC_TIMEOUT 2000

setenv PATH ".:/ecelib/linware/cadence/INCISIV/tools/bin:/usr/lib/":$PATH

cd ..
setenv sim `pwd`/sim

setenv design `pwd`/design
setenv model `pwd`/model
setenv verif `pwd`/verif

cd $sim


