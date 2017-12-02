mkdir build 2>/dev/null
mkdir build/Debug 2>/dev/null
cd build/Debug 
rm *.*
rm *
qmake ../../
make 2>&1 > /dev/null
./PMSetup 2>&1 > /dev/null