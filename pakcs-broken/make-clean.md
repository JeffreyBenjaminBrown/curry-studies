jeff@jeff-inspiron-2017:~/logic/curry/install/pakcs-2.0.2$ make clean
rm -f make.log
make cleantools
make[1]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2'
cd src && make clean
make[2]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/src'
rm -f /home/jeff/logic/curry/install/pakcs-2.0.2/bin/curry
rm -f c2p.state pakcs /home/jeff/logic/curry/install/pakcs-2.0.2/lib/.curry/pakcs/Prelude.pl prologbasics.pl
rm -f pakcsversion.pl
rm -rf libswi/ libsicstus/
make[2]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/src'
cd currytools && make uninstall
make[2]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/currytools'
make[3]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/currytools/cpm'
rm -Rf src/CPM.Main src/.curry vendor/*/src/.curry
rm -f /home/jeff/logic/curry/install/pakcs-2.0.2/bin/cypm /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-cypm
make[3]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/currytools/cpm'
make[3]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/currytools/cpns'
./stop
CPNS demon does not seem to be started.
/home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry
rm -f /home/jeff/logic/curry/install/pakcs-2.0.2/currytools/cpns/CPNSD
make[3]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/currytools/cpns'
make[3]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/currytools/optimize'
/home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry -r
rm -f BindingOpt
make[3]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/currytools/optimize'
make[3]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/currytools/www'
/home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry
rm -f /home/jeff/logic/curry/install/pakcs-2.0.2/currytools/www/SubmitForm /home/jeff/logic/curry/install/pakcs-2.0.2/currytools/www/Registry
make[3]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/currytools/www'
make[2]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/currytools'
cd tools && make clean
make[2]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/tools'
/home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry
cd Peval          && make clean
make[3]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/tools/Peval'
rm -f peval
/home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry
rm -f *_pe.flc *_pe.pl  # delete generated peval files
make[3]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/tools/Peval'
make[2]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/tools'
cd bin && rm -f pakcs
make[1]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2'
if [ -d lib ] ; then cd lib && make clean ; fi
make[1]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/lib'
rm -fr "CDOC"/bt3
rm -f "CDOC"/*
rm -f "/home/jeff/logic/curry/install/pakcs-2.0.2/docs/src/lib"/*
rm -fr .curry
make[1]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/lib'
cd examples && /home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry -r
if [ -d /home/jeff/logic/curry/install/pakcs-2.0.2/docs/src ] ; then cd /home/jeff/logic/curry/install/pakcs-2.0.2/docs/src && make clean ; fi
cd bin && rm -f sicstusprolog swiprolog
cd scripts && make clean
make[1]: Entering directory '/home/jeff/logic/curry/install/pakcs-2.0.2/scripts'
rm -f /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-makecgi /home/jeff/logic/curry/install/pakcs-2.0.2/bin/cleancurry /home/jeff/logic/curry/install/pakcs-2.0.2/bin/pakcs-fcypp
make[1]: Leaving directory '/home/jeff/logic/curry/install/pakcs-2.0.2/scripts'
if [ -d /home/jeff/logic/curry/install/pakcs-2.0.2/frontend ] ; then cd /home/jeff/logic/curry/install/pakcs-2.0.2/frontend && make clean ; fi
jeff@jeff-inspiron-2017:~/logic/curry/install/pakcs-2.0.2$ 
