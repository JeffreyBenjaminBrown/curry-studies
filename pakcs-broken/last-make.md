jeff@jeff-inspiron-2017:~/logic/curry/install/pakcs-2.0.2$ make
make config 2>&1 | tee -a make.log
make[1]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2'
cd scripts && make all
make[2]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/scripts'
make /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-makecgi /home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-fcypp
make[3]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/scripts'
mkdir -p /home/jeff/logic/curry/install/pakcs-2.0.2/bin
cat pakcs.sh | sed "s|^PAKCSBUILDDIR=.*$|PAKCSBUILDDIR=/home/jeff/logic/curry/install/pakcs-2.0.2|" | \
 sed "s|^PAKCSINSTALLDIR=.*$|PAKCSINSTALLDIR=|" > /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs
chmod 755 /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs
mkdir -p /home/jeff/logic/curry/install/pakcs-2.0.2/bin
cat pakcs-makecgi.sh | sed "s|^PAKCSBUILDDIR=.*$|PAKCSBUILDDIR=/home/jeff/logic/curry/install/pakcs-2.0.2|" | \
 sed "s|^PAKCSINSTALLDIR=.*$|PAKCSINSTALLDIR=|" > /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-makecgi
chmod 755 /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-makecgi
mkdir -p /home/jeff/logic/curry/install/pakcs-2.0.2/bin
cat cleancurry.sh | sed "s|^PAKCSBUILDDIR=.*$|PAKCSBUILDDIR=/home/jeff/logic/curry/install/pakcs-2.0.2|" | \
 sed "s|^PAKCSINSTALLDIR=.*$|PAKCSINSTALLDIR=|" > /home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry
chmod 755 /home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry
mkdir -p /home/jeff/logic/curry/install/pakcs-2.0.2/bin
cat pakcs-fcypp.sh | sed "s|^PAKCSBUILDDIR=.*$|PAKCSBUILDDIR=/home/jeff/logic/curry/install/pakcs-2.0.2|" | \
 sed "s|^PAKCSINSTALLDIR=.*$|PAKCSINSTALLDIR=|" > /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-fcypp
chmod 755 /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-fcypp
make[3]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/scripts'
make[2]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/scripts'
Try to use definitions from /home/jeff/logic/curry/install/pakcs-2.0.2/scripts/../pakcsinitrc...
======================================================================
PAKCS installation configured with (saved in /home/jeff/.pakcsinitrc):
SICSTUSDIR=
SWIPROLOG=/usr/bin/swipl
======================================================================
make[1]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2'
make build  2>&1 | tee -a make.log
make[1]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2'
make kernel
make[2]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2'
cd scripts && make all
make[3]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/scripts'
make /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-makecgi /home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-fcypp
make[4]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/scripts'
make[4]: '/home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs' is up to date.
make[4]: '/home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-makecgi' is up to date.
make[4]: '/home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry' is up to date.
make[4]: '/home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-fcypp' is up to date.
make[4]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/scripts'
make[3]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/scripts'
PAKCS installation configuration (file pakcsinitrc):
#####################################################################
# Set up the default variables according to the local installation:

# Directory of the SICStus-Prolog installation, i.e.,
# $SICSTUSDIR/bin/sicstus should be the name of the interpreter executable:
SICSTUSDIR=

# Executable of SWI-Prolog (if you don't have SICStus-Prolog)
# Note that the complete functionality of PAKCS is not available with
# SWI-Prolog and the efficiency is also slower than with SICStus-Prolog.
SWIPROLOG=/usr/bin/swipl

#####################################################################
# install front end:
make frontend
make[3]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2'
make[3]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2'
# pre-compile all libraries:
make[3]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/lib'
"/home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-frontend" --flat --extended -Wnone -i. AllSolutions -D__PAKCS__=200
Segmentation fault (core dumped)
Makefile:80: recipe for target '.curry/AllSolutions.fcy' failed
make[3]: *** [.curry/AllSolutions.fcy] Error 139
make[3]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/lib'
Makefile:163: recipe for target 'kernel' failed
make[2]: *** [kernel] Error 2
make[2]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2'
Makefile:155: recipe for target 'build' failed
make[1]: *** [build] Error 2
make[1]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2'
Make process logged in file make.log
jeff@jeff-inspiron-2017:~/logic/curry/install/pakcs-2.0.2$ 
